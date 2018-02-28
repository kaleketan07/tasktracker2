# Tasktracker

Additional features in this Task tracking application:

- Some users are managers
- The manager can be assigned to the user at the time of creation
- Only a Manager can assign a task to its Underlings
- The User can work on tasks in time time blocks
- To start working the user clicks "Start Working" button and when the user is done working he can click the "Stop Working" stop_button
- The Time blocks for a task can be viewed on the edit task page
- While editing the task the user can reassign it to only his underlings, if the user doesn't have any underlings the task stays assigned to himself
- The user can see his manager, the tasks he has assigned to his underlings and his agenda on his agenda page


Major Design Decisions:
- The edit and delete functionality for tasks is only allowed to the users to whom the task is Assigned
- If Alice is assigned a task A then A appears on Alice's agenda (home screen for users).
- Any other user say Bob can view the task in all tasks but it will not be visible on his agenda
- Since Bob is not assigned A he cannot edit or delete it
- For user convenience a list of all underling users is provided at the time of task creation.
- Also, at the time of user creation a list of all existing users is provided so that he can choose his manager
- The timeblocks table is added and is based on a many-to-one relationship with the tasks table
- A task "has-many" timeblocks, and a timeblock "belongs_to" a task
# tasktracker2
