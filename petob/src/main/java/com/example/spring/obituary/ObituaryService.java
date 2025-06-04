package com.example.spring.obituary;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ObituaryService {

    @Autowired
    private ObituaryMapper obituaryMapper;

    public void insertObituary(ObituaryDto dto) {
        obituaryMapper.insertObituary(dto);
    }

    public ObituaryDto selectLatestObituary() {
        return obituaryMapper.selectLatestObituary();
    }
}



