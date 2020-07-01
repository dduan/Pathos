## Steps for a new release
- Bump version in `Pathos.podspec`.
- Bump version in `Resources/Info.plist`.
- Bump version in `README.md`.
- In `CHANGELOG.md`, create a section for the new version and move changes from
  the master section there.
- Run `pod lib lint` and make sure it succeeds without errors or wannings.
- Check in all changes in git.
- Make a new tag for the version number.
- Push all changes and tag to GitHub and make a pull request.
- Make sure CI is green.
- Test the PR branch with a SwiftPM project using Pathos.
- Merge the PR.
- Create a GitHub release from the new version tag. Paste in content of
- corresponding change log.
- Run `pod trunk push`.
- Run `make docs` to generate and deploy the documentation website.
