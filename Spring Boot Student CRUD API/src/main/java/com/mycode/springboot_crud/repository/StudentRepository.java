package com.mycode.springboot_crud.repository;

import com.mycode.springboot_crud.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Integer> {
}
