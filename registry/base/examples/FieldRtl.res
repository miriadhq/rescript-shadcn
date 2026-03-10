@@directive("'use client'")

type item = {
  label: string,
  value: string,
}

let months: array<item> = [
  {label: "ش.ش", value: ""},
  {label: "٠١", value: "01"},
  {label: "٠٢", value: "02"},
  {label: "٠٣", value: "03"},
  {label: "٠٤", value: "04"},
  {label: "٠٥", value: "05"},
  {label: "٠٦", value: "06"},
  {label: "٠٧", value: "07"},
  {label: "٠٨", value: "08"},
  {label: "٠٩", value: "09"},
  {label: "١٠", value: "10"},
  {label: "١١", value: "11"},
  {label: "١٢", value: "12"},
]

let years: array<item> = [
  {label: "YYYY", value: ""},
  {label: "2024", value: "2024"},
  {label: "2025", value: "2025"},
  {label: "2026", value: "2026"},
  {label: "2027", value: "2027"},
  {label: "2028", value: "2028"},
  {label: "2029", value: "2029"},
]

@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <div className="w-full max-w-md py-6" dir="rtl">
    <form>
      <Field.Group>
        <Field.Set>
          <Field.Legend> {"طريقة الدفع"->React.string} </Field.Legend>
          <Field.Description>
            {"جميع المعاملات آمنة ومشفرة"->React.string}
          </Field.Description>
          <Field.Group>
            <Field>
              <Field.Label htmlFor="checkout-card-name-rtl">
                {"الاسم على البطاقة"->React.string}
              </Field.Label>
              <Input id="checkout-card-name-rtl" placeholder="Evil Rabbit" required={true} />
            </Field>
            <Field>
              <Field.Label htmlFor="checkout-card-number-rtl">
                {"رقم البطاقة"->React.string}
              </Field.Label>
              <Input
                id="checkout-card-number-rtl" placeholder="1234 5678 9012 3456" required={true}
              />
              <Field.Description>
                {"أدخل رقم البطاقة المكون من 16 رقمًا"->React.string}
              </Field.Description>
            </Field>
            <div className="grid grid-cols-3 gap-4">
              <Field>
                <Field.Label htmlFor="checkout-exp-month-rtl">
                  {"الشهر"->React.string}
                </Field.Label>
                <Select items={months}>
                  <Select.Trigger id="checkout-exp-month-rtl">
                    <Select.Value> {"ش.ش"->React.string} </Select.Value>
                  </Select.Trigger>
                  <Select.Content>
                    <Select.Group>
                      {months
                      ->Array.map(item =>
                        <Select.Item key={item.value} value={item.value}>
                          {item.label->React.string}
                        </Select.Item>
                      )
                      ->React.array}
                    </Select.Group>
                  </Select.Content>
                </Select>
              </Field>
              <Field>
                <Field.Label htmlFor="checkout-exp-year-rtl">
                  {"السنة"->React.string}
                </Field.Label>
                <Select items={years}>
                  <Select.Trigger id="checkout-exp-year-rtl">
                    <Select.Value> {"YYYY"->React.string} </Select.Value>
                  </Select.Trigger>
                  <Select.Content>
                    <Select.Group>
                      {years
                      ->Array.map(item =>
                        <Select.Item key={item.value} value={item.value}>
                          {item.label->React.string}
                        </Select.Item>
                      )
                      ->React.array}
                    </Select.Group>
                  </Select.Content>
                </Select>
              </Field>
              <Field>
                <Field.Label htmlFor="checkout-cvv-rtl"> {"CVV"->React.string} </Field.Label>
                <Input id="checkout-cvv-rtl" placeholder="123" required={true} />
              </Field>
            </div>
          </Field.Group>
        </Field.Set>
        <Field.Separator />
        <Field.Set>
          <Field.Legend> {"عنوان الفوترة"->React.string} </Field.Legend>
          <Field.Description>
            {"عنوان الفوترة المرتبط بطريقة الدفع الخاصة بك"->React.string}
          </Field.Description>
          <Field.Group>
            <Field orientation=BaseUi.Types.Orientation.Horizontal>
              <Checkbox id="checkout-same-as-shipping-rtl" defaultChecked={true} />
              <Field.Label htmlFor="checkout-same-as-shipping-rtl" className="font-normal">
                {"نفس عنوان الشحن"->React.string}
              </Field.Label>
            </Field>
          </Field.Group>
        </Field.Set>
        <Field.Set>
          <Field.Group>
            <Field>
              <Field.Label htmlFor="checkout-comments-rtl">
                {"تعليقات"->React.string}
              </Field.Label>
              <Textarea
                id="checkout-comments-rtl"
                placeholder="أضف أي تعليقات إضافية"
                className="resize-none"
              />
            </Field>
          </Field.Group>
        </Field.Set>
        <Field orientation=BaseUi.Types.Orientation.Horizontal>
          <Button type_="submit"> {"إرسال"->React.string} </Button>
          <Button variant=Button.Variant.Outline type_="button">
            {"إلغاء"->React.string}
          </Button>
        </Field>
      </Field.Group>
    </form>
  </div>
