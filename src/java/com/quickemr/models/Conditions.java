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
package com.quickemr.models;

/**
 *
 * @author Rob Garcia at rgarcia92.student.umuc.edu
 */
public final class Conditions {
    private int conID;
    String condition; /* Package-private: Used for sorting in DataAccess */
    private String description;

    /**
     * Basic constructor used to create a Conditions object
     */
    public Conditions() {
        /* Used to initialize object. See overloaded functions */
    }
    
    /**
     * Overloaded constructor used to create a Conditions object
     * @param conID        the unique condition identifier in the database
     * @param condition    the condition name
     * @param description  the condition description
     */
    public Conditions(int conID, String condition, String description) {
        this.conID = conID;
        this.condition = condition;
        this.description = description;
    }
  
    /* Getter functions */
    public int getConID() {
        return conID;
    }

    public String getCondition() {
        return condition;
    }
    
    public String getDescription() {
        return description;
    }
    
    /* Setter functions */
    public void setConID(int conID) {
        this.conID = conID;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}