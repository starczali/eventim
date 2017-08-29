package events.utils;
import org.springframework.stereotype.Component;

import javax.crypto.*;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.util.Base64;


//Deprecated
//!!!  DO NOT Use  !!!
//Methods not working
public class Encrypter {

    private SecretKey secretKey;
    private Cipher cipher;

    public Encrypter(){
        try{
        KeyGenerator keyGenerator = KeyGenerator.getInstance("DESede");
        secretKey = keyGenerator.generateKey();
        cipher = Cipher.getInstance("DESede");

        }catch (Exception e){
            System.out.print(e.getMessage());
        }
    }

    public byte[] encript(Integer number) throws InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        ByteBuffer byteBuffer = ByteBuffer.allocate(4);
        byteBuffer.putInt(number);
        byte[] text = byteBuffer.array();
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        return cipher.doFinal(text);
    }

    public Integer decript(byte[] text) throws InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] textDecrypted = cipher.doFinal(text);
        return new BigInteger(textDecrypted).intValue();
    }
}
