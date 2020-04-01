package com.grouper.model;

import java.util.*;

public interface GrouperDAO_interface {
          public void insert(GrouperVO grouperVO);
          public void update(GrouperVO grouperVO);
          public void delete(String grp_no);
          public GrouperVO findByPrimaryKey(String grp_no);
          
          public List<GrouperVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<EmpVO> getAll(Map<String, String[]> map); 
}
