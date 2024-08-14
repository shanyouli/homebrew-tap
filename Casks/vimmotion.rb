cask 'vimmotion' do
  version '1.2.2'
  sha256 'b7b86c22c9dc16eb75ee7982d5a45ab5c55ab7f14948ece46ec00387a9ce0703'

  url "https://github.com/dwarvesf/VimMotionApp/releases/download/v#{version}/VimMotion.#{version.major_minor}.dmg"
  name 'VimMotion'
  homepage 'https://github.com/dwarvesf/VimMotionApp/'

  depends_on macos: '>= :high_sierra'
  livecheck do
    url :url
    strategy :github_latest
  end
  app 'VimMotion.app'
end
