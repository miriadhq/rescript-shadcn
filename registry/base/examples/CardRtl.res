@@directive("'use client'")

@react.component
let make = () =>
  <Card className="w-full max-w-sm" dir="rtl">
    <Card.Header>
      <Card.Title> {"تسجيل الدخول إلى حسابك"->React.string} </Card.Title>
      <Card.Description>
        {"أدخل بريدك الإلكتروني أدناه لتسجيل الدخول إلى حسابك"->React.string}
      </Card.Description>
      <Card.Action>
        <Button variant=Button.Variant.Link> {"إنشاء حساب"->React.string} </Button>
      </Card.Action>
    </Card.Header>
    <Card.Content>
      <form>
        <div className="flex flex-col gap-6">
          <div className="grid gap-2">
            <Label htmlFor="email-rtl"> {"البريد الإلكتروني"->React.string} </Label>
            <Input id="email-rtl" type_="email" placeholder="m@example.com" required={true} />
          </div>
          <div className="grid gap-2">
            <div className="flex items-center">
              <Label htmlFor="password-rtl"> {"كلمة المرور"->React.string} </Label>
              <a
                href="#" className="ms-auto inline-block text-sm underline-offset-4 hover:underline"
              >
                {"نسيت كلمة المرور؟"->React.string}
              </a>
            </div>
            <Input id="password-rtl" type_="password" required={true} />
          </div>
        </div>
      </form>
    </Card.Content>
    <Card.Footer className="flex-col gap-2">
      <Button type_="submit" className="w-full"> {"تسجيل الدخول"->React.string} </Button>
      <Button variant=Button.Variant.Outline className="w-full">
        {"تسجيل الدخول باستخدام Google"->React.string}
      </Button>
    </Card.Footer>
  </Card>
