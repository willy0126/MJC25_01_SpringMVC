package com.example.spring.libs;

import lombok.Data;

/**
 * 게시판 페이징 처리를 위한 Pagination 클래스
 * - 전체 게시글 수를 기준으로 총 페이지 수, 시작/끝 페이지, offset 등을 계산
 */
@Data
public class Pagination {

    private int currentPage;        // 현재 페이지 번호
    private int totalCount;         // 전체 게시글 수
    private int listCountPerPage;   // 한 페이지에 보여줄 게시글 수
    private int pageCountPerPage;   // 하단에 보여질 페이지 번호 개수 (예: 1~5, 6~10)
    private int totalPages;         // 전체 페이지 수
    private int startPage;          // 현재 블록의 시작 페이지 번호
    private int endPage;            // 현재 블록의 끝 페이지 번호

    /**
     * 생성자에서 페이징 계산을 수행
     *
     * @param currentPage 현재 페이지 번호
     * @param listCountPerPage 한 페이지당 게시글 수
     * @param pageCountPerPage 페이지 하단에 보여줄 페이지 개수
     * @param totalCount 전체 게시글 수
     */
    public Pagination(int currentPage, int listCountPerPage, int pageCountPerPage, int totalCount) {
        this.currentPage = currentPage;
        this.listCountPerPage = listCountPerPage;
        this.pageCountPerPage = pageCountPerPage;
        this.totalCount = totalCount;

        // 전체 페이지 수 계산
        this.totalPages = (int) Math.ceil((double) totalCount / listCountPerPage);

        // 시작 페이지 번호 계산 (예: 1, 6, 11, ...)
        this.startPage = ((currentPage - 1) / pageCountPerPage) * pageCountPerPage + 1;

        // 끝 페이지 번호 계산 (마지막 페이지 범위 초과 방지)
        this.endPage = Math.min(startPage + (pageCountPerPage - 1), totalPages);
    }

    /**
     * 현재 페이지에서 DB 조회 시 OFFSET 값을 구함
     * 예: 2페이지일 경우, (2 - 1) * 10 = 10 → 11번째부터 가져옴
     *
     * @return OFFSET 값
     */
    public int offset() {
        return (currentPage - 1) * listCountPerPage;
    }
}
