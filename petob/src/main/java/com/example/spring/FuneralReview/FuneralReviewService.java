package com.example.spring.FuneralReview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.crypto.password.PasswordEncoder; // 현재 사용 안함
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional; // 트랜잭션 어노테이션 추가

import com.example.spring.libs.Pagination;

@Service
public class FuneralReviewService {
    @Autowired
    FuneralReviewDAO funeralReviewDAO;

    // @Autowired // 현재 후기 게시판에서 비밀번호를 사용하지 않으므로 주석 처리
    // PasswordEncoder passwordEncoder;

    public Map<String, Object> list(int currentPage, int listCountPerPage, int pageCountPerPage, String searchType, String searchKeyword) {
        int totalCount = funeralReviewDAO.totalCount(searchType, searchKeyword);
        Pagination pagination = new Pagination(currentPage, listCountPerPage, pageCountPerPage, totalCount);
        List<FuneralReviewDTO> posts = funeralReviewDAO.list(pagination.offset(), listCountPerPage, searchType, searchKeyword);

        Map<String, Object> result = new HashMap<>();
        result.put("posts", posts);
        result.put("searchType", searchType);
        result.put("searchKeyword", searchKeyword);
        result.put("pagination", pagination);

        return result;
    }

    @Transactional // 데이터 일관성을 위해 트랜잭션 처리
    public int create(FuneralReviewDTO post) {
        return funeralReviewDAO.create(post);
    }

    public FuneralReviewDTO read(int id) {
        return funeralReviewDAO.read(id);
    }

    @Transactional // 데이터 일관성을 위해 트랜잭션 처리
    public boolean update(FuneralReviewDTO post) {
        // 파일 정보가 null이면 DB에도 null로 업데이트 되도록 DAO 또는 Mapper에서 처리 필요
        // 혹은 여기서 DTO의 파일 관련 필드를 명시적으로 null로 설정할 수 있음
        // 예: if (post.getFileName() == null) post.setOriginalFileName(null);
        int result = funeralReviewDAO.update(post);
        return result > 0;
    }

    @Transactional // 데이터 일관성을 위해 트랜잭션 처리
    public boolean delete(int id) { // 매개변수를 int id로 변경
        int result = funeralReviewDAO.delete(id);
        return result > 0;
    }
}