#define RETURN_PRECISE_POSITION(A) new /datum/position(A)
#define RETURN_PRECISE_POINT(A) new /datum/point(A)
#define RETURN_POINT_VECTOR(ATOM, ANGLE, SPEED) (new /datum/point/vector(ATOM, null, null, null, null, ANGLE, SPEED))
#define RETURN_POINT_VECTOR_INCREMENT(ATOM, ANGLE, SPEED, AMT) (new /datum/point/vector(ATOM, null, null, null, null, ANGLE, SPEED, AMT))
