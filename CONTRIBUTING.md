# How to Contribute

We strongly welcome feedback and contributions to the ICDS User Documentation found at https://docs.icds.psu.edu. There are several ways to interact with our documentation depending on the type of contribution and your level of comfort and familiarity with Git workflows.

The easiest way to send feedback is by [creating an issue](#submitting-an-issue) or [contributing to a discussion](#submitting-a-discussion).

 - [Discussions](#submitting-a-discussion) are best used for general topic suggestions and broad feedback such as structure, overall formatting, and content additions
 - [Issues](#submitting-an-issue) are best for corrections or specific, small-scale changes

For more advanced Git users, you can also create your own fork of the repository to make suggested edits and [submit them using a Pull Request](#contributing-through-pull-requests).

## Submitting an Issue

Issues can be viewed and created at <https://github.com/PSU-ICDS/icds_docs/issues>. 

To add a new issue, please first check to see if the issue has been suggested by another individual. If it has not, create a new issue using the "New issue" button found in the top right corner.

If someone has already created an issue for your topic, you can add comments to provide additional information or support.


## Submitting a Discussion

Discussions can be viewed and created at <https://github.com/PSU-ICDS/icds_docs/discussions>. These are formatted and operate very much like a forum, where there are different topic Categories each containing different discussion threads. 

When posting a new discussion, please first check to see if the topic already exists. If it does not, please create a new discussion in the most applicable category.

You can also contribute to an existing discussion by upvoting or adding comments.


## Contributing through Pull Requests

The following instructions assume a familiarity with Git and GitHub, including creating a fork repository and submitting pull requests. If you are new to Git and want to learn more, we recommend the ["Version Control with Git" lesson](https://swcarpentry.github.io/git-novice/) provided by [The Carpentries](https://carpentries.org/).

### Repository and File Structure

The ICDS User Documentation uses MkDocs to format and serve a set of Markdown formatted documents. Content hosted in the repository in the Markdown format within the `docs` directory.  This content is synced to the webserver and rendered into the HTML seen on the website. Changes committed to the directory are then deployed live every 5 minutes.

The live documentation is hosted from the `main` branch. Once approved, proposed changes from the staging branch will be made live by appointed individuals.

All contributing pull requests must be made to the `staging` branch. Once approved and incorporated, staged changes can be viewed at <https://docs.icds.psu.edu/staging>. Any changes made to the `staging` branch will be incorporated into the site every 5 minutes. If the change does not show or the site becomes inoperable, it is likely due to an error in the code sent.


### Recommended Workflow:

To prevent conflicts with others, it is recommended to create your own fork of the repository and work on changes there. 

1. Create a fork of the PSU-ICDS/icds_docs GitHub repository within your own workspace
2. Commit changes within your own repository
3. Preview changes locally on your own machine (recommended)
4. Create a pull request between your repository/fork and the `staging` branch on the PSU-ICDS/icds_docs repository

To preview changes locally:

1. Install necessary tools on your local machine
	- Python - <https://www.python.org/downloads/release/python-3132/> 
	- MkDocs - <https://www.mkdocs.org/user-guide/installation/>
	- PyMdown - <https://facelessuser.github.io/pymdown-extensions/installation/>

2. Build the site using `mkdocs build`
3. Start the server using `mkdocs serve`
4. View the site in your browser: <http://127.0.0.1:8000/en/latest/>


## Helpful links:

- [MkDocs User Guide](https://www.mkdocs.org/user-guide/)
- [MkDocs Markdown Support Reference](https://www.markdownguide.org/tools/mkdocs/)
- [Markdown Guide](https://www.markdownguide.org/)
- [How to create a Fork in GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo)
- [How to create a Pull Request in GitHub](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
