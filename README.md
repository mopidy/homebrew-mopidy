Homebrew-Mopidy
===============

These formulae let you install Mopidy and Mopidy extensions with all
required dependencies on OS X.

How to install these formulae?
------------------------------

1. Run `brew tap homebrew/versions`. Some formulae in this tap depends on
   GStreamer 0.10 from the homebrew/versions repo.

2. Run `brew tap mopidy/mopidy` to get access to formulae in this repo.

3. Then, run `brew install <formula>`.

   If the formula conflicts with one from another tap, you can `brew install
   mopidy/mopidy/<formula>`.

   You can also install via URL: `brew install
   https://raw.github.com/mopidy/homebrew-mopidy/master/<formula>.rb`

Troubleshooting
---------------

See `brew help`, `man brew`, or the Homebrew
[wiki](https://github.com/Homebrew/homebrew/wiki).

Adding a formula to this tap
----------------------------

1. Fork this repository on GitHub.
2. Clone to your Mac.
3. Read [Homebrew and
   Python](https://github.com/Homebrew/homebrew/wiki/Homebrew-and-Python) and
   look at the other formulae here.
4. In your locally cloned `homebrew-mopidy` repo, create a new branch: `git
   checkout -b my-new-formula`
5. Write/edit your formula (Ruby file). Check the [Homebrew
   wiki](https://github.com/Homebrew/homebrew/wiki) for details.
6. Test it locally! `brew install ./my-new-formula.rb`. Does it install? Note,
   how `./<formula>.rb` will target the local file.
7. `git push origin my-new-formula` to get it into your GitHub as a
   new branch.
8. If you have to change something, add a commit and `git push`.
9. On GitHub, select your new branch and then click the "Pull Request" button.

License
-------

The formulae in this tap is licensed under the 2-clause BSD license, just like
Homebrew itself. See the file `LICENSE-BSD` for the license text.
