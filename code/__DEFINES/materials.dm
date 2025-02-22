/// Is the material from an ore? currently unused but exists atm for categorizations sake
#define MAT_CATEGORY_ORE "ore capable"

/// Hard materials, such as iron or metal
#define MAT_CATEGORY_RIGID "rigid material"


/// Gets the reference for the material type that was given
#define getmaterialref(A) (SSmaterials.materials[A] || A)

/// Flag for atoms, this flag ensures it isn't re-colored by materials. Useful for snowflake icons such as default toolboxes.
#define MATERIAL_COLOR (1<<0)
#define MATERIAL_ADD_PREFIX (1<<1)
#define MATERIAL_NO_EFFECTS (1<<2)


#define MAT_VALUE_EXTREMELY_LIGHT	 10
#define MAT_VALUE_VERY_LIGHT         30
#define MAT_VALUE_LIGHT              40
#define MAT_VALUE_NORMAL             50
#define MAT_VALUE_HEAVY              70
#define MAT_VALUE_VERY_HEAVY         80

#define MAT_VALUE_MALLEABLE          0
#define MAT_VALUE_SOFT              10
#define MAT_VALUE_FLEXIBLE          20
#define MAT_VALUE_RIGID             40
#define MAT_VALUE_HARD              60
#define MAT_VALUE_VERY_HARD         80

#define MAT_VALUE_DULL              10
#define MAT_VALUE_MATTE             20
#define MAT_VALUE_SHINY             40
#define MAT_VALUE_VERY_SHINY        60
#define MAT_VALUE_MIRRORED          80
