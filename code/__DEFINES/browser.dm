//Defines for the browser datum and its subtypes.

#define NULLABLE(condition) (condition || null)

#define CHOICE_YES "Make It So"
#define CHOICE_NO "Rescind"

#define CHOICE_CONFIRM CHOICE_YES
#define CHOICE_CANCEL CHOICE_NO
#define CHOICE_OK "So Be It"

#define DEFAULT_INPUT_CONFIRMATIONS list(CHOICE_CONFIRM, CHOICE_CANCEL)
#define DEFAULT_INPUT_CHOICES list(CHOICE_YES, CHOICE_NO)
