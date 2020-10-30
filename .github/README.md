# Array Splice
[heading__top]:
  #array-splice
  "&#x2B06; Removes elements from Bash array"


Removes elements from Bash array


## [![Byte size of Array Splice][badge__main__array_splice__source_code]][array_splice__main__source_code] [![Open Issues][badge__issues__array_splice]][issues__array_splice] [![Open Pull Requests][badge__pull_requests__array_splice]][pull_requests__array_splice] [![Latest commits][badge__commits__array_splice__main]][commits__array_splice__main]  [![Build Status][badge_travis_ci]][build_travis_ci]


---


- [:arrow_up: Top of Document][heading__top]

- [:building_construction: Requirements][heading__requirements]

- [:zap: Quick Start][heading__quick_start]

  - [:memo: Edit Your ReadMe File][heading__your_readme_file]
  - [:floppy_disk: Commit and Push][heading__commit_and_push]

- [&#x1F9F0; Usage][heading__usage]

- [:symbols: API][heading__api]

- [&#x1F5D2; Notes][heading__notes]

- [:chart_with_upwards_trend: Contributing][heading__contributing]

  - [:trident: Forking][heading__forking]
  - [:currency_exchange: Sponsor][heading__sponsor]

- [:card_index: Attribution][heading__attribution]

- [:balance_scale: Licensing][heading__license]


---



## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; Prerequisites and/or dependencies that this project needs to function properly"


This project is built and tested on devices with Bash version `4.4` or greater. Please check that your system has this available prior to opening new Issues, eg...


```Bash
bash --version | awk '/version/ { print; exit 0; }'
#> GNU bash, version 4.4.20(1)-release (x86_64-pc-linux-gnu)
```


______


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; Perhaps as easy as one, 2.0,..."


This repository encourages the use of Git Submodules to track dependencies


**Bash Variables**


```Bash
_module_name='array-splice'
_module_https_url="https://github.com/bash-utilities/array-splice.git"
_module_base_dir='modules'
_module_path="${_module_base_dir}/${_module_name}"
```


**Bash Submodule Commands**


```Bash
cd "<your-git-project-path>"

mkdir -vp "${_module_base_dir}"

git submodule add --name "${_module_name}"\
                  -b main\
                  "${_module_https_url}"\
                  "${_module_path}"
```


---


### Your ReadMe File
[heading__your_readme_file]:
  #your-readme-file
  "&#x1F4DD; Suggested additions for your ReadMe.md file so everyone has a good time with submodules"


Suggested additions for your _`ReadMe.md`_ file so everyone has a good time with submodules


```MarkDown
Clone with the following to avoid incomplete downloads


    git clone --recurse-submodules <url-for-your-project>


Update/upgrade submodules via


    git submodule update --init --merge --recursive
```


### Commit and Push
[heading__commit_and_push]:
  #commit-and-push
  "&#x1F4BE; It may be just this easy..."


```Bash
git add .gitmodules
git add "${_module_path}"


## Add any changed files too


git commit -F- <<'EOF'
:heavy_plus_sign: Adds `bash-utilities/array-splice#1` submodule



**Additions**


- `.gitmodules`, tracks submodules AKA Git within Git _fanciness_

- `README.md`, updates installation and updating guidance

- `modules/array-splice`, submodule removes elements from Bash array
EOF


git push origin gh-pages
```


**:tada: Excellent :tada:** your project is now ready to begin unitizing code from this repository!


______


## Usage
[heading__usage]:
  #usage
  "&#x1F9F0; How to utilize this repository"


Write a script that makes use of `array_splice` function...


```Bash
#!/usr/bin/env bash


## Find directory that this script resides in
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"


## Provides array_splice '<list_ref>' '<item>' '<offset>'
source "${__DIR__}/modules/array-splice/array-splice.sh"


list=(
    --beginning 'foo'
    --middle 'bar'
    --end 'spam'
)

printf '${list[*]} -> ( %s )\n' "${list[*]}"

echo "#> array_splice --target 'list' --element '--middle' --offset 1"
array_splice --target 'list' --element '--middle' --offset 1

printf '${list[*]} -> ( %s )\n' "${list[*]}"
## Expected output
#> ${list[*]} -> ( --beginning foo --end spam )
```


---


Alternatively this project maybe utilized interactively by sourcing within a `.bashrc`, or similar, configuration file, eg...


```Bash
mkdir -vp ~/git/hub/bash-utilities
cd ~/git/hub/bash-utilities

git clone git@github.com:bash-utilities/array-splice.git

tee -a "${HOME}/.bashrc" 1>/dev/null <<'EOF'
# Add array_splice to interactive shell
source ~/git/hub/bash-utilities/array-splice
EOF
```


Use `--help` flag to list available parameters, and assigned values, that `array_splice` function responds to...


```Bash
array_splice --help
```


______


## API
[heading__api]:
  #api
  "&#x1F523; Parameter documentation"


```
Removes element from array plus/minus offset


## Parameters

-t    --target <ArrayReferance> 

    {Required} - Target array reference to remove element(s) from


-d    --deleted <ArrayReferance> 

    {Optional} - Array reference to append removed element(s) to


-o    --offset <number> 0

    {Optional} - Index offset, may be negative or positive default: 1


-e    --element <number|string> "Some Value"

    {Required} - Element , if "--index" or "--regexp" is not defined, value to remove from target array


-i    --index <number> 0

    {Required} - If "--element" or "--regexp" is not defined, indexed value to remove from target array


-r    --regexp <RegExp> "'^--[[:print:]].*'"

    {Required} - If "--element" or "--index" is not defined, regular expression to remove from target array


-v    --verbose 0

    {Optional} - Prints parsed options and results if flag is present


-h    --help 1

    {Optional} - Prints this message if flag is present
```


______


## Notes
[heading__notes]:
  #notes
  "&#x1F5D2; Additional things to keep in mind when developing"


This repository may not be feature complete and/or fully functional, Pull Requests that add features or fix bugs are certainly welcomed.



______


## Contributing
[heading__contributing]:
  #contributing
  "&#x1F4C8; Options for contributing to array-splice and bash-utilities"


Options for contributing to array-splice and bash-utilities


---


### Forking
[heading__forking]:
  #forking
  "&#x1F531; Tips for forking array-splice"


Start making a [Fork][array_splice__fork_it] of this repository to an account that you have write permissions for.


- Add remote for fork URL. The URL syntax is _`git@github.com:<NAME>/<REPO>.git`_...


```Bash
cd ~/git/hub/bash-utilities/array-splice

git remote add fork git@github.com:<NAME>/array-splice.git
```


- Commit your changes and push to your fork, eg. to fix an issue...


```Bash
cd ~/git/hub/bash-utilities/array-splice


git commit -F- <<'EOF'
:bug: Fixes #42 Issue


**Edits**


- `<SCRIPT-NAME>` script, fixes some bug reported in issue
EOF


git push fork main
```


> Note, the `-u` option may be used to set `fork` as the default remote, eg. _`git push -u fork main`_ however, this will also default the `fork` remote for pulling from too! Meaning that pulling updates from `origin` must be done explicitly, eg. _`git pull origin main`_


- Then on GitHub submit a Pull Request through the Web-UI, the URL syntax is _`https://github.com/<NAME>/<REPO>/pull/new/<BRANCH>`_


> Note; to decrease the chances of your Pull Request needing modifications before being accepted, please check the [dot-github](https://github.com/bash-utilities/.github) repository for detailed contributing guidelines.


---


### Sponsor
  [heading__sponsor]:
  #sponsor
  "&#x1F4B1; Methods for financially supporting bash-utilities that maintains array-splice"


Thanks for even considering it!


Via Liberapay you may <sub>[![sponsor__shields_io__liberapay]][sponsor__link__liberapay]</sub> on a repeating basis.


Regardless of if you're able to financially support projects such as array-splice that bash-utilities maintains, please consider sharing projects that are useful with others, because one of the goals of maintaining Open Source repositories is to provide value to the community.


______


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [GitHub -- `github-utilities/make-readme`](https://github.com/github-utilities/make-readme)

- [StackOverflow -- RegEx matching in a Bash if statement](https://stackoverflow.com/questions/18709962/)


______


## License
[heading__license]:
  #license
  "&#x2696; Legal side of Open Source"


```
Removes elements from Bash array
Copyright (C) 2020 S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


For further details review full length version of [AGPL-3.0][branch__current__license] License.



[branch__current__license]:
  /LICENSE
  "&#x2696; Full length version of AGPL-3.0 License"


[badge__commits__array_splice__main]:
  https://img.shields.io/github/last-commit/bash-utilities/array-splice/main.svg

[commits__array_splice__main]:
  https://github.com/bash-utilities/array-splice/commits/main
  "&#x1F4DD; History of changes on this branch"


[array_splice__community]:
  https://github.com/bash-utilities/array-splice/community
  "&#x1F331; Dedicated to functioning code"


[issues__array_splice]:
  https://github.com/bash-utilities/array-splice/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."

[array_splice__fork_it]:
  https://github.com/bash-utilities/array-splice/
  "&#x1F531; Fork it!"

[pull_requests__array_splice]:
  https://github.com/bash-utilities/array-splice/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"

[array_splice__main__source_code]:
  https://github.com/bash-utilities/array-splice/
  "&#x2328; Project source!"

[badge__issues__array_splice]:
  https://img.shields.io/github/issues/bash-utilities/array-splice.svg

[badge__pull_requests__array_splice]:
  https://img.shields.io/github/issues-pr/bash-utilities/array-splice.svg

[badge__main__array_splice__source_code]:
  https://img.shields.io/github/repo-size/bash-utilities/array-splice


[sponsor__shields_io__liberapay]:
  https://img.shields.io/static/v1?logo=liberapay&label=Sponsor&message=bash-utilities

[sponsor__link__liberapay]:
  https://liberapay.com/bash-utilities
  "&#x1F4B1; Sponsor developments and projects that bash-utilities maintains via Liberapay"


[badge_travis_ci]:
  https://travis-ci.com/bash-utilities/array-splice.svg?branch=main

[build_travis_ci]:
  https://travis-ci.com/bash-utilities/array-splice

