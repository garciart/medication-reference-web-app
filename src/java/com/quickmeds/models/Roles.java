/*
 * Copyright (C) 2017 Rob Garcia at rgarcia92.student.umuc.edu
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.quickmeds.models;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public final class Roles {
    private int roleID;
    String role; /* Package-private: Used for sorting in DataAccess */
    private String description;

    /**
     * Basic constructor used to create a Roles object
     */
    public Roles() {
        /* Used to initialize object. See overloaded functions */
    }
    
    /**
     * Overloaded constructor used to create a Roles object
     * @param roleID       the unique role identifier in the database
     * @param role         the role name
     * @param description  the role description
     */
    public Roles(int roleID, String role, String description) {
        this.roleID = roleID;
        this.role = role;
        this.description = description;
    }
  
    /* Getter functions */
    public int getRoleID() {
        return roleID;
    }

    public String getRole() {
        return role;
    }
    
    public String getDescription() {
        return description;
    }
    
    /* Setter functions */
    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}