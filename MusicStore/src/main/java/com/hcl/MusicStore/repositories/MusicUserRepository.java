package com.hcl.MusicStore.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.hcl.MusicStore.entities.MusicUser;

@Repository
public interface MusicUserRepository extends JpaRepository<MusicUser, Integer> {

    public Optional<MusicUser> findByUsername(String username);
    public Iterable<MusicUser> findByFirstname(String firstname);
}