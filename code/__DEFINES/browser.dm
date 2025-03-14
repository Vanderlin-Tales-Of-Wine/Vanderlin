//Defines for the browser datum and its subtypes.

#define NULLABLE(condition) (condition || null)
#define CHOICE_OK "SO BE IT"

#define CHOICE_YES "MAKE IT SO"
#define CHOICE_NO "IT SHALL NOT BE"
#define CHOICE_NEVER "BEGONE, NEVER AGAIN"

#define CHOICE_CONFIRM "MAKE IT SO"
#define CHOICE_CANCEL "I RESCIND"

#define DEFAULT_INPUT_CONFIRMATIONS list(CHOICE_CONFIRM, CHOICE_CANCEL)
#define DEFAULT_INPUT_CHOICES list(CHOICE_YES, CHOICE_NO)
