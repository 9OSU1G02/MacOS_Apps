import Cocoa

class TaskView: NSView {
  var task: Task?

  var imageView: NSImageView
  var titleLabel: NSTextField
  var infoLabel: NSTextField
  var progressBar: NSProgressIndicator

  override init(frame frameRect: NSRect) {
    // set up subviews
    let imageFrame = NSRect(x: 10, y: 10, width: 20, height: 20)
    imageView = NSImageView(frame: imageFrame)
    imageView.imageScaling = .scaleProportionallyUpOrDown

    let titleFrame = NSRect(x: 40, y: 20, width: 220, height: 16)
    titleLabel = NSTextField(frame: titleFrame)

    let infoProgressFrame = NSRect(x: 40, y: 4, width: 220, height: 14)
    infoLabel = NSTextField(frame: infoProgressFrame)

    progressBar = NSProgressIndicator(frame: infoProgressFrame)
    progressBar.minValue = 0
    progressBar.maxValue = 100
    progressBar.isIndeterminate = false

    titleLabel = NSTextField(frame: titleFrame)
    titleLabel.backgroundColor = .clear
    titleLabel.isBezeled = false
    titleLabel.isEditable = false
    titleLabel.font = NSFont.systemFont(ofSize: 14)
    titleLabel.lineBreakMode = .byTruncatingTail

    infoLabel = NSTextField(frame: infoProgressFrame)
    infoLabel.backgroundColor = .clear
    infoLabel.isBezeled = false
    infoLabel.isEditable = false
    infoLabel.font = NSFont.systemFont(ofSize: 11)

    super.init(frame: frameRect)

    addSubview(imageView)
    addSubview(titleLabel)
    addSubview(infoLabel)
    addSubview(progressBar)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)

    if let task = task {
      let color = task.status.textColor

      imageView.image = NSImage(
        systemSymbolName: task.status.iconName,
        accessibilityDescription: task.status.statusText)
      imageView.contentTintColor = color

      titleLabel.stringValue = task.title
      titleLabel.textColor = color

      infoLabel.stringValue = task.status.statusText
      infoLabel.textColor = color

      switch task.status {
      case .notStarted:
        progressBar.isHidden = true
      case .inProgress:
        progressBar.doubleValue = task.progressPercent
        progressBar.isHidden = false
      case .complete:
        progressBar.isHidden = true
      }
    }
  }
}
