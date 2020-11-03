package com.gutmox.domain;

import com.gutmox.repositories.UsersRepository;

public class User {

	private final UsersRepository usersRepository;

	public User(UsersRepository usersRepository) {
		this.usersRepository = usersRepository;
	}

	public void create() {
		usersRepository.upsert(this);
	}
}
