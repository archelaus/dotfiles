#!/usr/bin/env python3

from i3ipc import Connection, Event

# Create the Connection object that can be used to send commands
# and subscribe to events.
i3 = Connection(auto_reconnect=True)

# change this depeneding on the class names you want to use in floating mode
classes = ["Alacritty"]


def handler(self, e):
    # select the focused workspace
    workspace = self.get_tree().find_focused().workspace()
    # get the windows open in the workspace
    leaves = workspace.leaves()
    # count the number of windows
    n = len(leaves)
    # if the number of windows is 1 and it's found in classes, enable floating mode
    if n == 1 and leaves[0].window_class in classes:
        payload = "floating enable"
    # otherwise set it back to default tiling mode
    else:
        payload = "floating disable"

    for leaf in leaves:
        leaf.command(payload)


# call the event handler each time a window is focused
# which happens when the number of windows change
i3.on(Event.WINDOW_FOCUS, handler)

# keep listening to events
i3.main()
