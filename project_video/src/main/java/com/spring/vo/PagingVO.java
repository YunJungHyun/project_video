package com.spring.vo;

public class PagingVO {

				// 현재페이지, 시작페이지, 끝페이지, 게시글 총 갯수, 페이지당 글 갯수, 마지막페이지, SQL쿼리에 쓸 start, end
		private int nowPage, startPage, endPage, total, cntPerPage, lastPage, start, end;
				// 한 눈에 보이는 페이지 쪽수
		private int cntPage = 1;
		
		//장르선택
		private String gnum;
		
		//리스트 보는 조건 선택
		private String sort;
		
		//나의 게시물 볼때
		private int unum;
		
		//즐겨찾기 게시물 볼떄
		private String fav;
		private String[] favArray;
		
		//최근 본 게시물 볼때
		private String recently;
		private String[] recentlyArray;
		
		//검색어
		private String searchTxt;
		
		public void setUnum(int unum) {
			this.unum = unum;
		}

		public PagingVO() {
			
		}
		
		public PagingVO(int total, int nowPage, int cntPerPage) {
			
			setNowPage(nowPage); //2
			setCntPerPage(cntPerPage);//10
			setTotal(total);//11
			
							//11    ,   10  >2
			calcLastPage(getTotal(), getCntPerPage());
							//2			, 1
			calcStartEndPage(getNowPage(), cntPage);
							//2		,	10
			calcStartEnd(getNowPage(), getCntPerPage());
			
		}
		
		// 제일 마지막 페이지 계산
		public void calcLastPage(int total, int cntPerPage) {
				//2			// 11 / 10 >> 값과 같거나 큰 정수를 반환 따라서 2 반환
			setLastPage((int) Math.ceil((double)total / (double)cntPerPage));
		}
		
		// 시작, 끝 페이지 계산
		public void calcStartEndPage(int nowPage, int cntPage) {
											// 2		/		1 		*		1  ==> 2
			setEndPage(((int)Math.ceil((double)nowPage / (double)cntPage)) * cntPage);
					//2       <  2  false;
			if (getLastPage() < getEndPage()) {
				setEndPage(getLastPage());
			}
					//  2 - 1 + 1 ==>2
			setStartPage(getEndPage() - cntPage + 1);
					//2 < 1  false;
			if (getStartPage() < 1) {
				setStartPage(1);
			}
		}
		
		// DB 쿼리에서 사용할 start, end값 계산
		public void calcStartEnd(int nowPage, int cntPerPage) {
			setEnd(nowPage * cntPerPage);
			setStart(getEnd() - cntPerPage + 1);
		}
		
		
		public int getCntPage() {
			return cntPage;
		}

		public void setCntPage(int cntPage) {
			this.cntPage = cntPage;
		}

		public int getUnum() {
			return unum;
		}
		
		public int getNowPage() {
			return nowPage;
		}
		public void setNowPage(int nowPage) {
			this.nowPage = nowPage;
		}
		public int getStartPage() {
			return startPage;
		}
		public void setStartPage(int startPage) {
			this.startPage = startPage;
		}
		public int getEndPage() {
			return endPage;
		}
		public void setEndPage(int endPage) {
			this.endPage = endPage;
		}
		public int getTotal() {
			return total;
		}
		public void setTotal(int total) {
			this.total = total;
		}
		public int getCntPerPage() {
			return cntPerPage;
		}
		public void setCntPerPage(int cntPerPage) {
			this.cntPerPage = cntPerPage;
		}
		public int getLastPage() {
			return lastPage;
		}
		public void setLastPage(int lastPage) {
			this.lastPage = lastPage;
		}
		public int getStart() {
			return start;
		}
		public void setStart(int start) {
			this.start = start;
		}
		public int getEnd() {
			return end;
		}
		public void setEnd(int end) {
			this.end = end;
		}	
		public int setCntPage() {
			return cntPage;
		}
		public void getCntPage(int cntPage) {
			this.cntPage = cntPage;
		}
		
		
		public String getGnum() {
			return gnum;
		}

		public void setGnum(String gnum) {
			this.gnum = gnum;
		}
		
		
		
		public String getSort() {
			return sort;
		}

		public void setSort(String sort) {
			this.sort = sort;
		}

		public String getFav() {
			return fav;
		}

		public void setFav(String fav) {
			this.fav = fav;
		}
		
		public String[] getFavArray() {
			return favArray;
		}

		public void setFavArray(String[] favArray) {
			this.favArray = favArray;
		}
		
		

		public String getRecently() {
			return recently;
		}

		public void setRecently(String recently) {
			this.recently = recently;
		}

		public String[] getRecentlyArray() {
			return recentlyArray;
		}

		public void setRecentlyArray(String[] recentlyArray) {
			this.recentlyArray = recentlyArray;
		}

		
		
		public String getSearchTxt() {
			return searchTxt;
		}

		public void setSearchTxt(String searchTxt) {
			this.searchTxt = searchTxt;
		}

		@Override
		public String toString() {
			return "PagingVO [nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage + ", total=" + total
					+ ", cntPerPage=" + cntPerPage + ", lastPage=" + lastPage + ", start=" + start + ", end=" + end
					+ ", cntPage=" + cntPage + "]";
		}
}
