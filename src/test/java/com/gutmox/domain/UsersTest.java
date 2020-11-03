package com.gutmox.domain;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;

import com.gutmox.repositories.UsersRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class UsersTest {

	@Mock
	UsersRepository usersRepository;

	User user;

	@BeforeEach
	void setUp(){
		user = new User(usersRepository);
	}

	@Test
	void should_create_new_users(){
		user.create();
		verify(usersRepository).upsert(user);
	}
}