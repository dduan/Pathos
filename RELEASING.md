## Steps for a new release
- Bump version in `Pathos.podspec`.
- Bump version in `Resources/Info.plist`.
- In `CHANGELOG.md`, create a section for the new version and move changes from
  the master section there.
- Run `make carthage-archive` to generate a `Pathos.framework.zip`.
- Run `pod lib lint` and make sure it succeeds without errors or wannings.
- Check in all changes in git.
- Make a new tag for the version number.
- Push all changes and tag to GitHub and make a pull request.
- Make sure CI is green.
- Test the PR branch with a SwiftPM project using Pathos.
- Merge the PR.
- Create a GitHub release from the new version tag. Paste in content of
- corresponding change log. Upload `Pathos.framework.zip` as part of the release.
- Run `pod trunk push`.
