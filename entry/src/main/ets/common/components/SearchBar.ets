@Component
export default struct SearchBar {
  placeholder: string = ''
  onChange: (value: string) => void = () => {}
  value: string = ''

  build() {
    Row() {
      TextInput({ placeholder: this.placeholder, text: this.value })
        .onChange((v: string) => this.onChange(v))
        .backgroundColor('#f5f5f5')
        .borderRadius(4)
        .padding(8)
        .width('100%')
    }
  }
}
