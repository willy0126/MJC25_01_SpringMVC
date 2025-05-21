package com.example.spring.FuneralReview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.spring.libs.Pagination;

@Service
public class FuneralReviewService {
     @Autowired
    FuneralReviewDAO funeralReviewDAO;

    @Autowired
    PasswordEncoder passwordEncoder;

    public Map<String, Object> list(int currentPage, int listCountPerPage, int pageCountPerPage, String searchType, String searchKeyword) {
        // 검색 조건에 따른 전체 게시글 수 조회
        int totalCount = funeralReviewDAO.totalCount(searchType, searchKeyword);

        // 페이지네이션 객체 생성 (총 게시글 수 기반으로 계산)
        Pagination pagination = new Pagination(currentPage, listCountPerPage, pageCountPerPage, totalCount);

        // 페이징 정보에 따른 게시글 목록 조회 (LIMIT offset, count)
        List<FuneralReviewDTO> posts = funeralReviewDAO.list(pagination.offset(), listCountPerPage, searchType, searchKeyword);

        // 결과 데이터 맵 구성
        Map<String, Object> result = new HashMap<>();
        result.put("posts", posts);
        result.put("searchType", searchType);
        result.put("searchKeyword", searchKeyword);
        result.put("pagination", pagination); // 뷰에서 페이지 번호 출력에 사용

        return result;
    }

    public int create(FuneralReviewDTO post) {
        // DAO를 호출하여 게시글을 DB에 저장하고 결과를 반환
        int result = funeralReviewDAO.create(post);
        return result;
    }

    public FuneralReviewDTO read(int id) {
        // DAO를 통해 ID에 해당하는 게시글을 조회
        return funeralReviewDAO.read(id);
    }

    public boolean update(FuneralReviewDTO post) {
        int result = funeralReviewDAO.update(post);
        return result > 0;
    }


    public boolean delete(FuneralReviewDTO post) {
        int result = funeralReviewDAO.delete(post.getId());
        return result > 0;
    }
}
