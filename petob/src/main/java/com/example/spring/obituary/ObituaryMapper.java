package com.example.spring.obituary;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ObituaryMapper {

    @Insert("INSERT INTO obituary (pet_name, passed_date, message, photo_path) " +
            "VALUES (#{petName}, #{passedDate}, #{message}, #{photoPath})")
    void insertObituary(ObituaryDto dto);

    @Select("SELECT * FROM obituary ORDER BY id DESC LIMIT 1")
    ObituaryDto selectLatestObituary();
}
