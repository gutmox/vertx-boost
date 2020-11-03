package com.gutmox.repositories;

import static org.junit.jupiter.api.Assertions.*;

import com.gutmox.domain.User;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UsersRepositoryTest {

	UsersRepository usersRepository;
	User user = new User(usersRepository);

	@BeforeEach
	void setUp(){
		usersRepository = new UsersRepository();
		user = new User(usersRepository);
	}

	@Test
	void should_store_new_users(){
		usersRepository.upsert(user);
	}
}