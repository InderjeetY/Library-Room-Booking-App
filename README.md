
# Library-Room-Booking-Application

    Library room booking application is built to allow members to search and book rooms in the library.

## Testing the Application

Application has three types of users: 

    - Library Member
    - Admin
    - Super Admin

The following credentials can be used to test each type of user:

    - Super Admin: Email: sadmin@gmail.com; Password: sadmin
    - Admin: Email: Email: spilani@ncsu.edu; Password:spilani
    - Library Member: Email: bsinha@ncsu.edu; Password: bsinha

Creating a Library Member:

    - To create a new library member, User needs to open the URL, click on Sign-up, enter required details and click on 'Create User'.

To login, User needs to log onto portal and enter valid login credentials then click on 'Login'.
To logout, User needs to log in and click on 'logout', user is logged out and sign in page is displayed.

Functionalities of a Library member:

    - Book a Room: user should log in as a library member click on 'book a room', enter required details and click 'Select Room'.
    - View Bookings: user needs to log in and click on 'My Bookings', all previous bookings are displayed.
    - Update Details: User needs to log in, click on 'Update details', enter the new details and click on 'Update User'.

Functionalities of Admin:

    - Update Details: After log in, click on 'Update Details', enter new details and click on 'Update User'.
    - Add new Admin: After Log in, cick on Add new admin, enter new admin details and click on 'Create User'.
    - Show all Admins: After log in, click on 'Show all Admins', all existing admins are displayed.
    - Show all Members: After log in, click on 'Show all Members', all existing members are displayed.
    - Delete Admin: After log in, click on 'Show all Admins', all existing admins are displayed, click on 'destroy' for a specific                           admin.
    - Delete Member: After log in, click on 'Show all Members', all existing members are displayed, click on 'destroy' for a specific                          member.
    - Create a room: After log in, click on 'Create a Room', enter details of new room, click on 'Create Room'.
    - Show all Rooms: After log in, click on 'Show all Rooms', all existing rooms are displayed.
    - Delete Room: After log in, click on 'Show all Rooms', all existing Rooms are displayed, click on 'destroy' for a specific Room.
    - Find and Book a Room: After log in, click on 'Find and Book a Room', enter room details and click on 'Select Room'.
    - View Bookings: After log in, click on 'My Bookings', all previous booking details are displayed.
    
Functionalities of Super Admin:

    - Super Admin can carry out all the functionalities of a admin the only difference is that the super admin cannot be deleted by a          normal admin.
    
Note: While updating Email Adress, if the new email address already exits in database, the user will be logged out but he can again           log back in with the same credentials as before.
      

Contributing

    - Fork it
    - Create your feature branch: git checkout -b my-new-branch
    - Commit your changes: git commit -am 'Add some feature'
    - Push to the branch: git push origin my-new-branch
    - Submit a pull request 

