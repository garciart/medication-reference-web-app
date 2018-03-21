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
public final class Medications {
    private int medID;
    String gName; /* Package-private: Used for sorting in DataAccess */
    private String bName;
    private String action;
    private String cond1;
    private String cond2;
    private String cond3;
    private int dea;
    private int btFlag;
    private String side_effects;
    private String interactions;
    private String warnings;

    /**
     * Basic constructor used to create a Medications object
     */
    public Medications() {
        /* Used to initialize object. See overloaded functions */
    }
    
    /**
     * Overloaded constructor used to create a Medications object
     *
     * @param medID        the unique medication identifier in the database
     * @param gName        the medication generic name
     * @param bName        the medication generic name
     * @param action       the medication action/mechanism
     * @param cond1        the primary condition the medication treats
     * @param cond2        the secondary condition the medication treats
     * @param cond3        the tertiary condition the medication treats
     * @param dea          the DEA Schedule class for controlled substances
     * @param btFlag       1 if the medication is a blood thinner, null if not
     * @param side_effects the medication side effects
     * @param interactions the medication interactions
     * @param warnings     the medication warnings
     */
    public Medications(int medID, String gName, String bName, String action, String cond1, String cond2, String cond3, int dea, int btFlag, String side_effects, String interactions, String warnings) {
        this.medID = medID;
        this.gName = gName;
        this.bName = bName;
        this.action = action;
        this.cond1 = cond1;
        this.cond2 = cond2;
        this.cond3 = cond3;
        this.dea = dea;
        this.btFlag = btFlag;
        this.side_effects = side_effects;
        this.interactions = interactions;
        this.warnings = warnings;
    }

    /**
     * Overloaded constructor used to create a Medications object
     *
     * @param medID        the unique medication identifier in the database
     * @param gName        the medication generic name
     * @param bName        the medication brand name
     * @param cond1        the primary condition the medication treats
     * @param cond2        the secondary condition the medication treats
     * @param cond3        the tertiary condition the medication treats
     * @param btFlag       1 if the medication is a blood thinner, null if not
     */
    public Medications(int medID, String gName, String bName, String cond1, String cond2, String cond3, int btFlag) {
        this.medID = medID;
        this.gName = gName;
        this.bName = bName;
        this.cond1 = cond1;
        this.cond2 = cond2;
        this.cond3 = cond3;
        this.btFlag = btFlag;
    }
    
    /* Getter functions */
    public int getMedID() {
        return medID;
    }

    public String getGName() {
        return gName;
    }
    
    public String getBName() {
        return bName;
    }
    
    public String getAction() {
        return action;
    }

    public String getCond1() {
        return cond1;
    }

    public String getCond2() {
        return cond2;
    }    

    public String getCond3() {
        return cond3;
    }
    
    public int getDEA() {
        return dea;
    }

    public int getBTFlag() {
        return btFlag;
    }
    
    public String getSide_Effects() {
        return side_effects;
    }
    
    public String getInteractions() {
        return interactions;
    }
    
    public String getWarnings() {
        return warnings;
    }
    
    /* Setter functions */
    public void setMedID(int medID) {
        this.medID = medID;
    }

    public void setGName(String gName) {
        this.gName = gName;
    }

    public void setBName(String bName) {
        this.bName = bName;
    }

    public void setAction(String action) {
        this.action = action;
    }
    
    public void setCond1(String cond1) {
        this.cond1 = cond1;
    }

    public void setCond2(String cond2) {
        this.cond2 = cond2;
    }

    public void setCond3(String cond3) {
        this.cond3 = cond3;
    }

    public void setDEA(int dea) {
        this.dea = dea;
    }
    
    public void setBTFlag(int btFlag) {
        this.btFlag = btFlag;
    }

    public void setSide_Effects(String side_effects) {
        this.side_effects = side_effects;
    }

    public void setInteractions(String interactions) {
        this.interactions = interactions;
    }

    public void setWarnings(String warnings) {
        this.warnings = warnings;
    }
}