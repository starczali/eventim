package events.dao;

import events.model.TemporaryUser;

import java.util.List;

public interface TemporaryUserDAO {
    public TemporaryUser findTemporaryUserById(Integer id);
    public List<TemporaryUser> getAllTemporaryUsers();
    public void saveTemporaryUser(TemporaryUser user);
    public void deleteTemporaryUser(TemporaryUser user);
    public void deleteTemporaryUserById(Integer id);
}
