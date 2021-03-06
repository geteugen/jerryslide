*&---------------------------------------------------------------------*
*& Report ZGROUPBY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZGROUPBY.

DATA flights TYPE TABLE OF spfli WITH EMPTY KEY.

START-OF-SELECTION.

SELECT * FROM  spfli
         WHERE carrid = 'LH'
         INTO TABLE @flights.

BREAK-POINT.
DATA members LIKE flights.
LOOP AT flights INTO DATA(flight)
     GROUP BY ( carrier = flight-carrid cityfr = flight-cityfrom )
              ASCENDING
              ASSIGNING FIELD-SYMBOL(<group>).
  CLEAR members.
  LOOP AT GROUP <group> ASSIGNING FIELD-SYMBOL(<flight>).
    members = VALUE #( BASE members ( <flight> ) ).
  ENDLOOP.
  cl_demo_output=>write( members ).
ENDLOOP.
cl_demo_output=>display( ).