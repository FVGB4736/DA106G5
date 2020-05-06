package com.path.model;

import java.util.List;

public interface PathDAO_interface {
	 public PathVO insert(PathVO pathVO);
     public void update(PathVO pathVO);
     public void delete(String path_no);
     public PathVO findByPrimaryKey(String path_no);
     public List<PathVO> getAll();
     public byte[] getImage(String path_no);
     public String insertPathFromWeb(PathVO pathVO);
}
