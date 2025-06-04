package com.example.spring.notice;

import org.apache.ibatis.annotations.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class NoticeDao {

    @Autowired
    private SqlSession sqlSession;

    private final String namespace = "com.example.spring.notice.NoticeMapper";

    public List<NoticeDto> selectAllNotices() {
        return sqlSession.selectList(namespace + ".selectAllNotices");
    }

    public NoticeDto selectNoticeById(Long id) {
        return sqlSession.selectOne(namespace + ".selectNoticeById", id);
    }

    public int insertNotice(NoticeDto dto) {
        return sqlSession.insert(namespace + ".insertNotice", dto);
    }

    public int updateNotice(NoticeDto dto) {
        return sqlSession.update(namespace + ".updateNotice", dto);
    }

    public int deleteNotice(Long id) {
        return sqlSession.delete(namespace + ".deleteNotice", id);
    }

    public int selectTotalCount() {
        return sqlSession.selectOne(namespace + ".selectTotalCount");
    }

    public List<NoticeDto> selectNoticesByTitle(String title) {
        return sqlSession.selectList(namespace + ".selectNoticesByTitle", title);
    }

    public List<NoticeDto> selectRecentNotices(int limit) {
        return sqlSession.selectList(namespace + ".selectRecentNotices", limit);
    }
}
