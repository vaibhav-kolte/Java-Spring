package com.mycode.springboot_crud.service;

import com.mycode.springboot_crud.model.Student;
import com.mycode.springboot_crud.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentRepository studentRepository;

    public List<Student> listAll(){
        return studentRepository.findAll();
    }

    public void save(Student student){
        studentRepository.save(student);
    }

    public Student get(Integer id){
        return studentRepository.findById(id).get();
    }

    public void delete(Integer id){
        studentRepository.deleteById(id);
    }
}