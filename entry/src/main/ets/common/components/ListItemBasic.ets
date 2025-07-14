@Component
export default struct ListItemBasic {
  left: string = ''
  right: string = ''
  onClick: () => void = () => {}

  build() {
    Row() {
      Text(this.left)
      Spacer()
      Text(this.right)
    }
    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    .border({ width: 0, style: BorderStyle.Solid })
    .borderBottom({ width: 1, color: '#eee' })
    .onClick(this.onClick)
  }
}
