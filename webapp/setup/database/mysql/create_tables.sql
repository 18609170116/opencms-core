CREATE TABLE CMS_USERS (
    USER_ID VARCHAR(36) BINARY NOT NULL,
    USER_NAME VARCHAR(128) BINARY NOT NULL,
    USER_PASSWORD VARCHAR(64) BINARY NOT NULL,
    USER_FIRSTNAME VARCHAR(128) NOT NULL,
    USER_LASTNAME VARCHAR(128) NOT NULL,
    USER_EMAIL VARCHAR(128) NOT NULL,
    USER_LASTLOGIN BIGINT NOT NULL,
    USER_FLAGS INT NOT NULL,
    USER_OU VARCHAR(128),
    USER_DATECREATED BIGINT NOT NULL,
    PRIMARY KEY    (USER_ID), 
    UNIQUE INDEX USER_FQN_IDX (USER_OU, USER_NAME),
    INDEX USER_NAME_IDX (USER_NAME),
    INDEX USER_OU_IDX (USER_OU)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_USERDATA (
    USER_ID VARCHAR(36) BINARY NOT NULL,
    DATA_KEY VARCHAR(255) BINARY NOT NULL,
    DATA_VALUE BLOB,
    DATA_TYPE VARCHAR(128) BINARY NOT NULL,
    PRIMARY KEY (USER_ID, DATA_KEY),
    INDEX USERDATA_USER_IDX (USER_ID),
    INDEX USERDATA_DATA_IDX (DATA_KEY)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_HISTORY_PRINCIPALS (
    PRINCIPAL_ID VARCHAR(36) BINARY NOT NULL,
    PRINCIPAL_NAME VARCHAR(128) BINARY NOT NULL,
    PRINCIPAL_DESCRIPTION VARCHAR(255) NOT NULL,
    PRINCIPAL_OU VARCHAR(128),
    PRINCIPAL_EMAIL VARCHAR(128) NOT NULL,
    PRINCIPAL_TYPE VARCHAR(5) NOT NULL,
    PRINCIPAL_USERDELETED VARCHAR(36) BINARY NOT NULL,
    PRINCIPAL_DATEDELETED BIGINT NOT NULL,
    PRIMARY KEY (PRINCIPAL_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_GROUPS (
    GROUP_ID VARCHAR(36) BINARY NOT NULL,
    PARENT_GROUP_ID VARCHAR(36) BINARY NOT NULL,
    GROUP_NAME VARCHAR(128) BINARY NOT NULL,
    GROUP_DESCRIPTION VARCHAR(255) NOT NULL,
    GROUP_FLAGS INT NOT NULL,
    GROUP_OU VARCHAR(128),
    PRIMARY KEY (GROUP_ID),
    UNIQUE INDEX GROUP_FQN_IDX (GROUP_OU, GROUP_NAME),
    INDEX GROUP_NAME_IDX (GROUP_NAME),
    INDEX GROUP_OU_IDX (GROUP_OU),
    INDEX PARENT_GROUP_ID_IDX (PARENT_GROUP_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_GROUPUSERS (
    GROUP_ID VARCHAR(36) BINARY NOT NULL,
    USER_ID VARCHAR(36) BINARY NOT NULL,
    GROUPUSER_FLAGS INT NOT NULL,
    PRIMARY KEY (GROUP_ID, USER_ID),
    INDEX GROUP_ID_IDX (GROUP_ID),
    INDEX USER_ID_IDX (USER_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_PROJECTS (
    PROJECT_ID VARCHAR(36) NOT NULL,
    PROJECT_NAME VARCHAR(200) BINARY NOT NULL,
    PROJECT_DESCRIPTION VARCHAR(255) NOT NULL,
    PROJECT_FLAGS INT NOT NULL,
    PROJECT_TYPE INT NOT NULL,
    USER_ID VARCHAR(36) BINARY NOT NULL,
    GROUP_ID VARCHAR(36) BINARY NOT NULL, 
    MANAGERGROUP_ID VARCHAR(36) BINARY NOT NULL,
    DATE_CREATED BIGINT NOT NULL,
    PROJECT_OU VARCHAR(128) NOT NULL,
    PRIMARY KEY (PROJECT_ID), 
    UNIQUE INDEX PROJECT_NAME_DATE_CREATED_IDX (PROJECT_OU, PROJECT_NAME, DATE_CREATED),
    INDEX PROJECT_FLAGS_IDX (PROJECT_FLAGS),
    INDEX PROJECT_GROUP_ID_IDX (GROUP_ID),
    INDEX PROJECT_MANAGERGROUP_ID_IDX (MANAGERGROUP_ID),
    INDEX PROJECT_OU_NAME_IDX (PROJECT_OU, PROJECT_NAME), 
    INDEX PROJECT_NAME_IDX (PROJECT_NAME),
    INDEX PROJECT_OU_IDX (PROJECT_OU),
    INDEX PROJECT_USER_ID_IDX (USER_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_HISTORY_PROJECTS (
    PROJECT_ID VARCHAR(36) NOT NULL,
    PROJECT_NAME VARCHAR(255) BINARY NOT NULL,
    PROJECT_DESCRIPTION VARCHAR(255) NOT NULL,
    PROJECT_TYPE INT NOT NULL,
    USER_ID VARCHAR(36) BINARY NOT NULL,
    GROUP_ID VARCHAR(36) BINARY NOT NULL,
    MANAGERGROUP_ID VARCHAR(36) BINARY NOT NULL,
    DATE_CREATED BIGINT NOT NULL,    
    PUBLISH_TAG INT NOT NULL,
    PROJECT_PUBLISHDATE BIGINT,
    PROJECT_PUBLISHED_BY VARCHAR(36) BINARY NOT NULL,
    PROJECT_OU VARCHAR(128) BINARY NOT NULL,
    PRIMARY KEY (PUBLISH_TAG)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_PROJECTRESOURCES (
    PROJECT_ID VARCHAR(36) NOT NULL,
    RESOURCE_PATH TEXT BINARY NOT NULL,
    PRIMARY KEY (PROJECT_ID, RESOURCE_PATH(255)),
    INDEX RESOURCE_PATH_IDX (RESOURCE_PATH(255))
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_HISTORY_PROJECTRESOURCES (
    PUBLISH_TAG INT NOT NULL,
    PROJECT_ID VARCHAR(36) NOT NULL,
    RESOURCE_PATH TEXT BINARY NOT NULL,
    PRIMARY KEY (PUBLISH_TAG, PROJECT_ID, RESOURCE_PATH(255))
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_PROPERTYDEF (
    PROPERTYDEF_ID VARCHAR(36) BINARY NOT NULL, 
    PROPERTYDEF_NAME VARCHAR(128) BINARY NOT NULL,
    PROPERTYDEF_TYPE INT NOT NULL,
    PRIMARY KEY (PROPERTYDEF_ID), 
    UNIQUE INDEX PROPERTYDEF_NAME_IDX (PROPERTYDEF_NAME)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_ONLINE_PROPERTYDEF (
    PROPERTYDEF_ID VARCHAR(36) BINARY NOT NULL, 
    PROPERTYDEF_NAME VARCHAR(128) BINARY NOT NULL,
    PROPERTYDEF_TYPE INT NOT NULL,
    PRIMARY KEY (PROPERTYDEF_ID), 
    UNIQUE INDEX PROPERTYDEF_NAME_IDX (PROPERTYDEF_NAME)    
) ENGINE = MYISAM CHARACTER SET UTF8;
                                        
CREATE TABLE CMS_HISTORY_PROPERTYDEF (
    PROPERTYDEF_ID VARCHAR(36) BINARY NOT NULL, 
    PROPERTYDEF_NAME VARCHAR(128) BINARY NOT NULL,
    PROPERTYDEF_TYPE INT NOT NULL,
    PRIMARY KEY (PROPERTYDEF_ID), 
    UNIQUE INDEX PROPERTYDEF_NAME_IDX (PROPERTYDEF_NAME)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_PROPERTIES (
    PROPERTY_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTYDEF_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTY_MAPPING_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTY_MAPPING_TYPE INT NOT NULL,
    PROPERTY_VALUE TEXT NOT NULL,
    PRIMARY KEY (PROPERTY_ID),
    INDEX PROPERTYDEF_ID_IDX (PROPERTYDEF_ID),
    INDEX PROPERTY_MAPPING_ID_IDX (PROPERTY_MAPPING_ID),    
    UNIQUE INDEX PROPERTYDEF_ID_MAPPING_ID_IDX (PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;
                                         
CREATE TABLE CMS_ONLINE_PROPERTIES (
    PROPERTY_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTYDEF_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTY_MAPPING_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTY_MAPPING_TYPE INT NOT NULL,
    PROPERTY_VALUE TEXT NOT NULL,
    PRIMARY KEY(PROPERTY_ID),
    INDEX PROPERTYDEF_ID_IDX (PROPERTYDEF_ID),
    INDEX PROPERTY_MAPPING_ID_IDX (PROPERTY_MAPPING_ID),    
    UNIQUE INDEX PROPERTYDEF_ID_MAPPING_ID_IDX (PROPERTYDEF_ID, PROPERTY_MAPPING_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;
                                                                              
CREATE TABLE CMS_HISTORY_PROPERTIES (
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTYDEF_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTY_MAPPING_ID VARCHAR(36) BINARY NOT NULL,
    PROPERTY_MAPPING_TYPE INT NOT NULL,
    PROPERTY_VALUE TEXT NOT NULL,
    PUBLISH_TAG INT,
    PRIMARY KEY(STRUCTURE_ID,PROPERTYDEF_ID,PROPERTY_MAPPING_TYPE,PUBLISH_TAG),
    INDEX PROPERTYDEF_ID_IDX (PROPERTYDEF_ID),
    INDEX PROPERTY_MAPPING_ID_IDX (PROPERTY_MAPPING_ID),    
    INDEX PROPERTYDEF_ID_MAPPING_ID_IDX (PROPERTYDEF_ID, PROPERTY_MAPPING_ID),
    INDEX VERSION_IDX (STRUCTURE_ID,PUBLISH_TAG)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_ONLINE_ACCESSCONTROL (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    PRINCIPAL_ID VARCHAR(36) BINARY NOT NULL,
    ACCESS_ALLOWED INT,
    ACCESS_DENIED INT,
    ACCESS_FLAGS INT,
    PRIMARY KEY (RESOURCE_ID, PRINCIPAL_ID),
    INDEX PRINCIPAL_ID_IDX (PRINCIPAL_ID),
    INDEX RESOURCE_ID_IDX (RESOURCE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_ACCESSCONTROL (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    PRINCIPAL_ID VARCHAR(36) BINARY NOT NULL,
    ACCESS_ALLOWED INT,
    ACCESS_DENIED INT,
    ACCESS_FLAGS INT,
    PRIMARY KEY (RESOURCE_ID, PRINCIPAL_ID),
    INDEX PRINCIPAL_ID_IDX (PRINCIPAL_ID),
    INDEX RESOURCE_ID_IDX (RESOURCE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_PUBLISH_HISTORY (
    HISTORY_ID VARCHAR(36) BINARY NOT NULL,
    PUBLISH_TAG INT NOT NULL,
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_PATH TEXT BINARY NOT NULL,
    RESOURCE_STATE INT NOT NULL,
    RESOURCE_TYPE INT NOT NULL,
    SIBLING_COUNT INT NOT NULL,
    PRIMARY KEY (HISTORY_ID, PUBLISH_TAG, STRUCTURE_ID, RESOURCE_PATH(255)),
    INDEX PUBLISH_TAG_IDX (PUBLISH_TAG),
    INDEX HISTORY_ID_IDX (HISTORY_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_PUBLISH_JOBS (
    HISTORY_ID VARCHAR(36) BINARY NOT NULL,
    PROJECT_ID VARCHAR(36) NOT NULL,
    PROJECT_NAME VARCHAR(255) BINARY NOT NULL,
    USER_ID VARCHAR(36) BINARY NOT NULL,
    PUBLISH_LOCALE VARCHAR(16) BINARY NOT NULL,
    PUBLISH_FLAGS INT NOT NULL,
    PUBLISH_LIST LONGBLOB,
    PUBLISH_REPORT LONGBLOB,
    RESOURCE_COUNT INT NOT NULL,
    ENQUEUE_TIME BIGINT NOT NULL,
    START_TIME BIGINT NOT NULL,
    FINISH_TIME BIGINT NOT NULL,
    PRIMARY KEY (HISTORY_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_RESOURCE_LOCKS (
  RESOURCE_PATH TEXT BINARY NOT NULL,
  USER_ID VARCHAR(36) NOT NULL,
  PROJECT_ID VARCHAR(36) NOT NULL,
  LOCK_TYPE INT NOT NULL,
  INDEX RESOURCE_LOCKS_IDX (RESOURCE_PATH(255))
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_STATICEXPORT_LINKS (
    LINK_ID VARCHAR(36) BINARY NOT NULL,
    LINK_RFS_PATH TEXT BINARY NOT NULL,
    LINK_TYPE INT NOT NULL,
    LINK_PARAMETER TEXT,
    LINK_TIMESTAMP BIGINT,    
    PRIMARY KEY (LINK_ID),    
    INDEX LINK_RFS_PATH_IDX (LINK_RFS_PATH(255))
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_STRUCTURE (
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    PARENT_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_PATH TEXT BINARY NOT NULL,
    STRUCTURE_STATE SMALLINT UNSIGNED NOT NULL,
    DATE_RELEASED BIGINT NOT NULL,
    DATE_EXPIRED BIGINT NOT NULL,
    STRUCTURE_VERSION INT NOT NULL,
    PRIMARY KEY (STRUCTURE_ID),
    INDEX STRUCTURE_ID_RESOURCE_PATH_IDX (STRUCTURE_ID, RESOURCE_PATH(255)),    
    INDEX RESOURCE_PATH_RESOURCE_ID_IDX (RESOURCE_PATH(255), RESOURCE_ID),
    INDEX STRUCTURE_ID_RESOURCE_ID_IDX (STRUCTURE_ID, RESOURCE_ID),
    INDEX STRUCTURE_STATE_IDX (STRUCTURE_STATE),
    INDEX PARENT_ID_IDX (PARENT_ID),
    INDEX RESOURCE_PATH_IDX (RESOURCE_PATH(255)),
    INDEX RESOURCE_ID_IDX (RESOURCE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_ONLINE_STRUCTURE (
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    PARENT_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_PATH TEXT BINARY NOT NULL,
    STRUCTURE_STATE SMALLINT UNSIGNED NOT NULL,
    DATE_RELEASED BIGINT NOT NULL,
    DATE_EXPIRED BIGINT NOT NULL,
    STRUCTURE_VERSION INT NOT NULL,
    PRIMARY KEY (STRUCTURE_ID),
    INDEX STRUCTURE_ID_RESOURCE_PATH_IDX (STRUCTURE_ID, RESOURCE_PATH(255)),    
    INDEX RESOURCE_PATH_RESOURCE_ID_IDX (RESOURCE_PATH(255), RESOURCE_ID),
    INDEX STRUCTURE_ID_RESOURCE_ID_IDX (STRUCTURE_ID, RESOURCE_ID),
    INDEX STRUCTURE_STATE_IDX (STRUCTURE_STATE),
    INDEX PARENT_ID_IDX (PARENT_ID),
    INDEX RESOURCE_PATH_IDX (RESOURCE_PATH(255)),
    INDEX RESOURCE_ID_IDX (RESOURCE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_HISTORY_STRUCTURE (
    PUBLISH_TAG INT NOT NULL,
    VERSION INT NOT NULL,
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    PARENT_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_PATH TEXT BINARY NOT NULL,
    STRUCTURE_STATE SMALLINT UNSIGNED NOT NULL,
    DATE_RELEASED BIGINT NOT NULL,
    DATE_EXPIRED BIGINT NOT NULL,
    STRUCTURE_VERSION INT NOT NULL,
    PRIMARY KEY (STRUCTURE_ID,PUBLISH_TAG,VERSION),
    INDEX STRUCTURE_ID_IDX (STRUCTURE_ID),
    INDEX RESOURCE_PATH_IDX (RESOURCE_PATH(255)),
    INDEX PUBLISH_TAG_IDX (PUBLISH_TAG),
    INDEX VERSION_IDX (VERSION)    
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_RESOURCES (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_TYPE INT NOT NULL,
    RESOURCE_FLAGS INT NOT NULL,
    RESOURCE_STATE    SMALLINT UNSIGNED NOT NULL,
    RESOURCE_SIZE INT NOT NULL,                                         
    DATE_CONTENT BIGINT NOT NULL,                                             
    SIBLING_COUNT INT NOT NULL,
    DATE_CREATED BIGINT NOT NULL,
    DATE_LASTMODIFIED BIGINT NOT NULL,
    USER_CREATED VARCHAR(36) BINARY NOT NULL,                                         
    USER_LASTMODIFIED VARCHAR(36) BINARY NOT NULL,
    PROJECT_LASTMODIFIED VARCHAR(36) NULL,          
    RESOURCE_VERSION INT NOT NULL,
    PRIMARY KEY(RESOURCE_ID),
    INDEX PROJECT_LASTMODIFIED_IDX (PROJECT_LASTMODIFIED),
    INDEX PROJECT_LASTMODIFIED_RESOURCE_SIZE_IDX (PROJECT_LASTMODIFIED, RESOURCE_SIZE),
    INDEX RESOURCE_SIZE_IDX (RESOURCE_SIZE),
    INDEX DATE_LASTMODIFIED_IDX (DATE_LASTMODIFIED),
    INDEX RESOURCE_TYPE_IDX (RESOURCE_TYPE)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_ONLINE_RESOURCES (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_TYPE INT NOT NULL,
    RESOURCE_FLAGS INT NOT NULL,
    RESOURCE_STATE    SMALLINT UNSIGNED NOT NULL,
    RESOURCE_SIZE INT NOT NULL,
    DATE_CONTENT BIGINT NOT NULL,                                             
    SIBLING_COUNT INT NOT NULL,    
    DATE_CREATED BIGINT NOT NULL,
    DATE_LASTMODIFIED BIGINT NOT NULL,
    USER_CREATED VARCHAR(36) BINARY NOT NULL,                                         
    USER_LASTMODIFIED VARCHAR(36) BINARY NOT NULL,
    PROJECT_LASTMODIFIED VARCHAR(36) NULL,
    RESOURCE_VERSION INT NOT NULL,
    PRIMARY KEY(RESOURCE_ID),
    INDEX PROJECT_LASTMODIFIED_IDX (PROJECT_LASTMODIFIED),
    INDEX PROJECT_LASTMODIFIED_RESOURCE_SIZE_IDX (PROJECT_LASTMODIFIED, RESOURCE_SIZE),
    INDEX RESOURCE_SIZE_IDX (RESOURCE_SIZE),
    INDEX DATE_LASTMODIFIED_IDX (DATE_LASTMODIFIED),
    INDEX RESOURCE_TYPE_IDX (RESOURCE_TYPE)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_HISTORY_RESOURCES (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    RESOURCE_TYPE INT NOT NULL,
    RESOURCE_FLAGS INT NOT NULL,
    RESOURCE_STATE    SMALLINT UNSIGNED NOT NULL,
    RESOURCE_SIZE INT NOT NULL,
    DATE_CONTENT BIGINT NOT NULL,
    SIBLING_COUNT INT NOT NULL,    
    DATE_CREATED BIGINT NOT NULL,
    DATE_LASTMODIFIED BIGINT NOT NULL,
    USER_CREATED VARCHAR(36) BINARY NOT NULL,
    USER_LASTMODIFIED VARCHAR(36) BINARY NOT NULL,
    PROJECT_LASTMODIFIED VARCHAR(36) NULL,
    PUBLISH_TAG INT NOT NULL,
    RESOURCE_VERSION INT NOT NULL,
    PRIMARY KEY(RESOURCE_ID,PUBLISH_TAG),
    INDEX RESOURCE_ID_IDX (RESOURCE_ID),
    INDEX PUBLISH_TAG_IDX (PUBLISH_TAG)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_CONTENTS (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    FILE_CONTENT LONGBLOB NOT NULL,
    PRIMARY KEY(RESOURCE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_CONTENTS (
    RESOURCE_ID VARCHAR(36) BINARY NOT NULL,
    FILE_CONTENT LONGBLOB NOT NULL,
    PUBLISH_TAG_FROM INT,
    PUBLISH_TAG_TO INT,
    ONLINE_FLAG INT,
    PRIMARY KEY(RESOURCE_ID, PUBLISH_TAG_FROM),
    UNIQUE INDEX CONTENTS_IDX (RESOURCE_ID, PUBLISH_TAG_TO),
    INDEX RESOURCE_ID_IDX (RESOURCE_ID),
    INDEX PUBLISH_TAG_FROM_IDX (PUBLISH_TAG_FROM),
    INDEX PUBLISH_TAG_TO_IDX (PUBLISH_TAG_TO),
    INDEX ONLINE_IDX (RESOURCE_ID, ONLINE_FLAG)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_ONLINE_RESOURCE_RELATIONS (
    RELATION_SOURCE_ID VARCHAR(36) BINARY NOT NULL,
    RELATION_SOURCE_PATH TEXT BINARY NOT NULL,
    RELATION_TARGET_ID VARCHAR(36) BINARY NOT NULL,
    RELATION_TARGET_PATH TEXT BINARY NOT NULL,
    RELATION_TYPE INT NOT NULL,
    INDEX SOURCE_ID_IDX (RELATION_SOURCE_ID),
    INDEX SOURCE_PATH_IDX (RELATION_SOURCE_PATH(255)),
    INDEX TARGET_ID_IDX (RELATION_TARGET_ID),
    INDEX TARGET_PATH_IDX (RELATION_TARGET_PATH(255)),
    INDEX TYPE_IDX (RELATION_TYPE)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_OFFLINE_RESOURCE_RELATIONS (
    RELATION_SOURCE_ID VARCHAR(36) BINARY NOT NULL,
    RELATION_SOURCE_PATH TEXT BINARY NOT NULL,
    RELATION_TARGET_ID VARCHAR(36) BINARY NOT NULL,
    RELATION_TARGET_PATH TEXT BINARY NOT NULL,
    RELATION_TYPE INT NOT NULL,
    INDEX SOURCE_ID_IDX (RELATION_SOURCE_ID),
    INDEX SOURCE_PATH_IDX (RELATION_SOURCE_PATH(255)),
    INDEX TARGET_ID_IDX (RELATION_TARGET_ID),
    INDEX TARGET_PATH_IDX (RELATION_TARGET_PATH(255)),
    INDEX TYPE_IDX (RELATION_TYPE)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_LOG (
    USER_ID VARCHAR(36) BINARY NOT NULL,
    LOG_DATE BIGINT NOT NULL,
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    LOG_TYPE INT NOT NULL,
    LOG_DATA VARCHAR(1024),
    PRIMARY KEY(USER_ID, LOG_DATE, LOG_TYPE, STRUCTURE_ID),
    UNIQUE INDEX CMS_LOG_UNIQUE_IDX (USER_ID, LOG_DATE, STRUCTURE_ID),
    INDEX CMS_LOG_01_IDX (USER_ID),
    INDEX CMS_LOG_02_IDX (STRUCTURE_ID),
    INDEX CMS_LOG_03_IDX (LOG_DATE),
    INDEX CMS_LOG_04_IDX (LOG_TYPE),
    INDEX CMS_LOG_05_IDX (USER_ID, STRUCTURE_ID),
    INDEX CMS_LOG_06_IDX (USER_ID, LOG_DATE),
    INDEX CMS_LOG_07_IDX (USER_ID, STRUCTURE_ID, LOG_DATE),
    INDEX CMS_LOG_08_IDX (USER_ID, LOG_TYPE, STRUCTURE_ID, LOG_DATE),
    INDEX CMS_LOG_09_IDX (USER_ID, LOG_DATE, LOG_TYPE)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_SUBSCRIPTION_VISIT (
	USER_ID VARCHAR(36) BINARY NOT NULL,
	VISIT_DATE BIGINT NOT NULL,
	STRUCTURE_ID VARCHAR(36) BINARY,
	PRIMARY KEY(USER_ID, VISIT_DATE),
	UNIQUE INDEX CMS_SUBSCRIPTION_VISIT_UNIQUE_IDX (USER_ID, VISIT_DATE, STRUCTURE_ID),
	INDEX CMS_SUBSCRIPTION_VISIT_01_IDX (USER_ID),
	INDEX CMS_SUBSCRIPTION_VISIT_02_IDX (STRUCTURE_ID),
	INDEX CMS_SUBSCRIPTION_VISIT_03_IDX (VISIT_DATE),
	INDEX CMS_SUBSCRIPTION_VISIT_04_IDX (USER_ID, STRUCTURE_ID),
	INDEX CMS_SUBSCRIPTION_VISIT_05_IDX  (USER_ID, VISIT_DATE),
	INDEX CMS_SUBSCRIPTION_VISIT_06_IDX (USER_ID, STRUCTURE_ID, VISIT_DATE)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_SUBSCRIPTION (
    PRINCIPAL_ID VARCHAR(36) BINARY NOT NULL,
    STRUCTURE_ID VARCHAR(36) BINARY NOT NULL,
    DATE_DELETED BIGINT NOT NULL,
    PRIMARY KEY(PRINCIPAL_ID, STRUCTURE_ID),
    INDEX PRINCIPAL_ID_IDX (PRINCIPAL_ID),
    INDEX STRUCTURE_ID_IDX (STRUCTURE_ID),
    INDEX DATE_DELETED_IDX (DATE_DELETED),
    INDEX SUBSCRIPTION_ALL_IDX (PRINCIPAL_ID, STRUCTURE_ID, DATE_DELETED)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_COUNTERS (
	NAME VARCHAR(255) NOT NULL,
	COUNTER INT NOT NULL,
	PRIMARY KEY(NAME)
) ENGINE = MYISAM CHARACTER SET UTF8;  

CREATE TABLE CMS_OFFLINE_URLNAME_MAPPINGS (
	NAME VARCHAR(255) NOT NULL,
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	STATE INT NOT NULL,
	DATE_CHANGED BIGINT NOT NULL,
	LOCALE VARCHAR(10),
	INDEX CMS_OFFLINE_URLNAME_MAPPINGS_01_IDX (NAME),
	INDEX CMS_OFFLINE_URLNAME_MAPPINGS_02_IDX (STRUCTURE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8;

CREATE TABLE CMS_ONLINE_URLNAME_MAPPINGS (
	NAME VARCHAR(255) NOT NULL,
	STRUCTURE_ID VARCHAR(36) NOT NULL,
	STATE INT NOT NULL,
	DATE_CHANGED BIGINT NOT NULL,
	LOCALE VARCHAR(10),
	INDEX CMS_ONLINE_URLNAME_MAPPINGS_01_IDX (NAME),
	INDEX CMS_ONLINE_URLNAME_MAPPINGS_02_IDX (STRUCTURE_ID)
) ENGINE = MYISAM CHARACTER SET UTF8; 








