//
//  constants.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#define DATABASE_FILE_NAME @"database.sqlite"


//size constants
#define IMG_TEST_HEIGHT 50
#define OFFSET_TEST_IMAGE 10
#define OFFSET_TEST_TEXT 20
#define NAVIGATION_BAR_HEIGHT 44
#define STATUS_BAR_HEIGHT 20
#define TOOLBAR_HEIGHT 44
#define HEIGHT_SEARCH_BAR 44

//text constants
#define BLANK_STRING @""
#define TEST_INCOMPLETE @"Escala incompleta"
#define TEST_COMPLETE @"Escala completa"
#define TEST_RESULT_TEXT @"Jadadosis aguda"


//sql queries
#define SQL_QUERY_ESCALA @"SELECT * FROM escalas"
#define SQL_QUERY_PREGUNTAS @"SELECT * FROM preguntas WHERE id_escala=%d ORDER BY orden ASC"
#define SQL_QUERY_GET_SCORE_STRING @"SELECT descripcion1, descripcion2 FROM valoraciones WHERE id_escala=%d AND valor=%d"
#define SQL_QUERY_GET_TEST_DESCRIPTION @"SELECT desc FROM escalas WHERE id=%d"


//database field constants
#define DB_FIELD_ID @"id"
#define DB_FIELD_ESCALA @"escala_id"
#define DB_FIELD_DESCRIPCION1 @"descripcion1"
#define DB_FIELD_DESCRIPCION2 @"descripcion2"