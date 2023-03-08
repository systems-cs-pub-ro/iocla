# Contributing to IOCLA

We welcome contributions to the content and source code of `IOCLA` course.
You may contribute by:

* opening [issues](https://github.com/systems-cs-pub-ro/iocla/issues)
* taking part in [discussions](https://github.com/systems-cs-pub-ro/iocla/discussions)
* creating [pull requests](https://github.com/systems-cs-pub-ro/iocla/pulls) to update the content

When opening an issue, please clearly state the problem.
Make sure it's reproducible.
Add images if required.
Also, if relevant, detail the environment you used (OS, software versions).
Ideally, if the issue is something you could fix, open a pull request with the fix.

Use discussions for bringing up ideas on content, new chapters, new sections.
Provide support to others asking questions and take part in suggestions brought by others.
Please be civil when taking part in discussions.

For pull requests, please follow the [GitHub flow](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork): create a fork of the repository, create your own branch, do commits, push changes to your branch, do a pull request (PR).
The destination branch of pull requests is the default `master` branch.

## Coding Style

For code contributions, please respect the [Linux Kernel coding style](https://www.kernel.org/doc/html/v4.10/process/coding-style.html).
To make this process easier, download [checkpatch.pl](https://github.com/systems-cs-pub-ro/iocla/blob/master/scripts/checkpatch.pl) and run [this command](https://github.com/systems-cs-pub-ro/iocla/blob/master/.github/workflows/main.yml#L12), it will show you all style errors.
Alternatively, there's a [VS Code extension](https://marketplace.visualstudio.com/items?itemName=idanp.checkpatch) that integrates the patch into its editor (follow the instructions on the extension page).

## Content Writing Style

For contributions to the documentation, write each sentence on a new line.
This way, changing one sentence only affects one line in the source code.

Use the first person plural when writing documentation and tutorials.
Use phrases like "we run the command / app", "we look at the source code", "we find the flag".

Use the second person for challenges and other individual activities.
Use phrases like "find the flag", "run this command", "download the tool".