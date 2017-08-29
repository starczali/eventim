package events.dao;

import java.util.List;

import org.springframework.stereotype.Service;

import events.model.User;



public interface UserDAO {
	public User findUserById(Integer id);
	public List<User> getAllUsers();
	public void saveUser(User user);
	public void deleteUser(User user);
	public void deleteUserById(Integer id);
	public User findUserAtLogin(String username);
}
