//
//  constants.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 15/07/12.
//  Copyright (c) 2012 shahshangraj@gmail.com. All rights reserved.
//

#define SPLASH_SLEEP_TIME 2
#define DATABASE_FILE_NAME @"database.sqlite"

//font related
#define FONT_NAME @"Verdana"
#define FONT_HEIGHT 16
#define TEXT_BOLD 0

//size constants
#define IMG_TEST_HEIGHT 75
#define OFFSET_TEST_IMAGE 10
#define OFFSET_TEST_TEXT 20
#define NAVIGATION_BAR_HEIGHT 44
#define STATUS_BAR_HEIGHT 20
#define TOOLBAR_HEIGHT 44
#define HEIGHT_SEARCH_BAR 44
#define SECTION_HEADER_HEIGHT 20

//text constants
#define BLANK_STRING @""
#define TEST_INCOMPLETE @"Escala incompleta"
#define TEST_COMPLETE @"Escala completa"
#define TEST_RESULT_TEXT @"Jadadosis aguda"
#define APP_TITLE @"D-Health"
#define SEARCH_TITLE @"Busca..."
#define BACK_BUTTON_TITLE @"Back"

//sql queries
#define SQL_QUERY_ALL_ESCALA @"SELECT * FROM escalas"
#define SQL_QUERY_ESCALA @"SELECT * FROM escalas WHERE escala LIKE '%@%%'"
#define SQL_QUERY_PREGUNTAS @"SELECT * FROM preguntas WHERE id_escala=%d ORDER BY orden ASC"
#define SQL_QUERY_GET_SCORE_STRING @"SELECT descripcion1, descripcion2 FROM valoraciones WHERE id_escala=%d AND valor=%d"
#define SQL_QUERY_GET_TEST_DESCRIPTION @"SELECT desc FROM escalas WHERE id=%d"
#define SQL_QUERY_SEARCH_ESCALA @"SELECT * FROM escalas WHERE escala LIKE '%%%@%%'"
#define SQL_QUERY_GET_INFOBAR_DATA @"SELECT %@ FROM infobar LIMIT 1"

//database field constants
#define DB_FIELD_ID @"id"
#define DB_FIELD_ESCALA @"escala_id"
#define DB_FIELD_DESCRIPCION1 @"descripcion1"
#define DB_FIELD_DESCRIPCION2 @"descripcion2"
#define DB_FIELD_ACERCA @"acerca"
#define DB_FIELD_AYUDA @"ayuda"
#define DB_FIELD_FEEDBACK @"feedback"
