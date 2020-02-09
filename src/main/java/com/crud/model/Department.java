package com.crud.model;

public class Department {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column dept.dept_id
     *
     * @mbg.generated Sat Feb 01 01:39:37 CST 2020
     */
    private Integer deptId;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column dept.dept_name
     *
     * @mbg.generated Sat Feb 01 01:39:37 CST 2020
     */
    private String deptName;

    public Department() {
    }

    public Department(Integer deptId, String deptName) {
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column dept.dept_id
     *
     * @param deptId the value for dept.dept_id
     *
     * @mbg.generated Sat Feb 01 01:39:37 CST 2020
     */
    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column dept.dept_name
     *
     * @return the value of dept.dept_name
     *
     * @mbg.generated Sat Feb 01 01:39:37 CST 2020
     */
    public String getDeptName() {
        return deptName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column dept.dept_name
     *
     * @param deptName the value for dept.dept_name
     *
     * @mbg.generated Sat Feb 01 01:39:37 CST 2020
     */
    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}