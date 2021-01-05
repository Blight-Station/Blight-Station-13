# Blight Station Modular Folders

ATTENTION! For any and all changes to the codebase they MUST be added in this folder tree. Unless approved by a host and/or maintainer, any and all pull requests to the Blight Station **[Repository](https://github.com/Blight-Station/Blight-Station-13)** that have files not in the modular folder will be rejected. If you're unsure or have questions about the process, please contact either the hosts, or maintainer team for questions and support.

Thank you all for your continued work on improving the codebase, and a thank you to Aurora Station and the SpaceStation 13 community for all the hard work everyone has put into this passion project that has ran for so long.

# To-do's for Pull Requests

When creating a new pull-request we ask that you follow these rules as they're a mix of helpful bits of information, and also a checklist to ensure the request will be approved.

- Check for any open **[bugs/issues](https://github.com/Blight-Station/Blight-Station-13/issues)** reported on our Github and ensure that you mention in your pull request that you're fixing a bug. You can do so by looking for the bug ID and reference it in your pull request.

- Comments. Any new lines of code you're adding that aren't a simple fix or typo/edit needs to have comments on it. The most comment type of comment we'll expect to see is a simple `//This will do x to y`. If you're adding something that is a new system or type of item that will have multiple instances to it, PLEASE include a FULL comment tree of what ever variable will do. If you're unsure, reach out to the host or maintainer team for tips and help.

- Sprites/Textures MUST be added into the modular folder system as editing existing sprite sheets can run into multiple issues, and add confusion to declaration of object sprite paths. Sprite teams that aren't too versed in code; if you need help merging or how to add the proper folder directory to your content reach out to the hosts, or maintainer teams, for help.

- Mappers: Adding new maps, or changes to new maps will be the exception to this modular process. You will want to put map files in the maps folder under your specific map file. However, any non map changes that would not fall in the standard map files will need to follow the same modular system as any other .dm file outside of the `#MAPNAME_areas.dm` or other files that are in the `core` folder.

- Pull Requests will always be test merged before getting added to the core repo. The exception to this is if it's a bugfix that the hosts and maintainers are aware of and need to fix asap.

# Additional Notes

As more changes and updates go through, we'll be adding more steps to check, as well as tips and help for our development team so we make this as easy and readable as possible for us all.
