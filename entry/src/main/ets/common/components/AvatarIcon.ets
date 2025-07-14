@Component
export default struct AvatarIcon {
  size: number = 40
  src: string = ''

  build() {
    Image(this.src)
      .width(this.size)
      .height(this.size)
      .borderRadius(this.size / 2)
      .backgroundColor('#ddd')
  }
}
