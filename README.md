# MediWeb work sample

The base for this work sample is a simplistic ETL (Extract, Transform and Load) system. The extract reads data from a Google Sheets document, the transform builds some HTML pages using that data, and the load outputs the data to the local filesystem.

## The Assignment

To see not only how you write tests and code, but also how you may refactor when requirements change, the assignment comes in two parts:

### Part 1

Our client, Medical Websites With Style, is asking for a modification to their page publishing system. Please email "mwws@mediweb.jp" including the tag "[MWWS Start]" in the subject line for further instructions.

### Part 2 (after submitting Part 1)

When you submit part 1, MWWS will send you further instructions. At this point, you may want to add new tests and refactor your code to allow the clean implementation of the new requirements.


## Getting set up

### Ruby install


To keep things relatively short and focused, this is a pure Ruby work sample, no frameworks involved. If you need help installing Ruby, see [the official documentation](https://www.ruby-lang.org/en/documentation/installation/).

We will be using the latest Ruby version as of the time of writing: 2.6.3.

## Anonymity setup

To ensure an unbiased review, the submission will be graded anonymously. To ensure anonymity, right after cloning the repo locally, please issue the following commands at the top of the repository:

    ruby --version
    # ^ Just to check. You should have 2.6.3

    export MWWS_ID=$(ruby -e 'require "securerandom"; puts SecureRandom.alphanumeric(8)')
    git config --local user.name "${MWWS_ID}"
    git config --local user.email "<>"
    echo "Your MWWS_ID is: ${MWWS_ID}"

To confirm the setup:

    git config --local user.name

This should display a string of random letters that will be used to identify your anonymous submission. Now all your commits in this repo will be anonymous.



### Dependency management

This project uses [Bundler](https://bundler.io) for dependency management. Be sure to use it when installing Ruby libraries (gems). If you are unfamiliar with Bundler, see [here](https://bundler.io/guides/using_bundler_in_applications.html) for detailed instructions.

If you don't have Bundler installed for Ruby 2.6.3 yet, you will need to:

    gem install bundler

Clone the repository locally (do not fork it), and in order to install the dependencies, execute the following inside the repo's top-level folder:

    bundle install

### Test suite

Verify the test suite is running with:

    bundle exec rspec

You can then run tests continuously to help you get quick feedback when developing:

    bundle exec guard

## Environment setup

To actually run the ETL task, you will need to set up some environment variables (SPREADSHEET_ID and GOOGLE_SHEETS_API_KEY). The actual values for these should have been emailed to you. If you are familiar with `direnv` or something similar, you can copy the `.env.sample` to `.env` and put the values there. Otherwise, you can simply use a good ol' `export`.

With the environment variables in place, you should now be able to run the ETL:

    bundle exec rake publish_pages

## Repo bundling

For submissions, please run the following at the top level of the repo:

    (MWWS_ID=$(git config --local user.name) && git bundle create mwws-${MWWS_ID}.repo --all)

This generates the repo bundle, which you can attach to emails.

## Grading

We will be looking at the following when evaluating your work sample:

- Thoroughness and attention to detail
- Ability to follow instructions
- Consistency with the existing codebase
- Readability and maintainability


## Notes

Really important work sample notes:

- If you feel like you're spending too much time on the work sample, we completely understand your reluctance to spend more than 4-8 hours on this exercise and respect your right to withdraw from the application process at any time with no hard feelings or impact on future applications. However, please be aware that incomplete work samples are very unlikely to achieve a passing grade.
- This is a 100% open book test - you should be reading existing code, searching Google for solutions to common problems, etc...
- We understand that Ruby may not be a language you're very comfortable in, but since MediWeb is primarily a Ruby shop today, and since we know that many non-Rubyists contribute to Ruby open source projects in real life, we think this is a legitimate work sample.
- Finally, we are looking for any and all feedback about the work sample process including whether you think it's an appropriate effort to ask somebody to do as part of the application process (i.e. it doesn't take too long, isn't too onerous of a process, etc...).
