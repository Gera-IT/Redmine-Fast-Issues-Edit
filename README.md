# Redmine Overlay Issues Manager

This Plugin adds overlay to issues page, so issues can be opened in modal window instead of loading new page. This decreases loading time, and removed need to return back to index page after each edit. You also can create new issue via overlay.


## Not implemented yet:
Add new items to issues list

Change data after issue update

## How to install

Exec `cd redmine/plugins`

Run `git clone https://github.com/avdept/redmine_overlay_issues_manager.git` `redmine_overlay_issues_manager`

Run `rake redmine:plugins:assets`

Restart redmine server

Go To permissions page and select who can use this plugin(this can be applied to all users to increase speed of managing issues'.
Next go to project modules and enable it for project.


