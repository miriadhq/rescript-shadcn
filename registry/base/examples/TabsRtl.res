@@directive("'use client'")

@react.component
let make = () =>
  <Tabs defaultValue="overview" className="w-full max-w-sm" dir="rtl">
    <Tabs.List dir="rtl">
      <Tabs.Trigger value="overview"> {"نظرة عامة"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="analytics"> {"التحليلات"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="reports"> {"التقارير"->React.string} </Tabs.Trigger>
      <Tabs.Trigger value="settings"> {"الإعدادات"->React.string} </Tabs.Trigger>
    </Tabs.List>
    <Tabs.Content value="overview">
      <Card dir="rtl">
        <Card.Header>
          <Card.Title> {"نظرة عامة"->React.string} </Card.Title>
          <Card.Description>
            {"عرض مقاييسك الرئيسية وأنشطة المشروع الأخيرة. تتبع التقدم عبر جميع مشاريعك النشطة."->React.string}
          </Card.Description>
        </Card.Header>
        <Card.Content className="text-muted-foreground text-sm">
          {"لديك ١٢ مشروعًا نشطًا و٣ مهام معلقة."->React.string}
        </Card.Content>
      </Card>
    </Tabs.Content>
    <Tabs.Content value="analytics">
      <Card dir="rtl">
        <Card.Header>
          <Card.Title> {"التحليلات"->React.string} </Card.Title>
          <Card.Description>
            {"تتبع مقاييس الأداء ومشاركة المستخدمين. راقب الاتجاهات وحدد فرص النمو."->React.string}
          </Card.Description>
        </Card.Header>
        <Card.Content className="text-muted-foreground text-sm">
          {"زادت مشاهدات الصفحة بنسبة ٢٥٪ مقارنة بالشهر الماضي."->React.string}
        </Card.Content>
      </Card>
    </Tabs.Content>
    <Tabs.Content value="reports">
      <Card dir="rtl">
        <Card.Header>
          <Card.Title> {"التقارير"->React.string} </Card.Title>
          <Card.Description>
            {"إنشاء وتنزيل تقاريرك التفصيلية. تصدير البيانات بتنسيقات متعددة للتحليل."->React.string}
          </Card.Description>
        </Card.Header>
        <Card.Content className="text-muted-foreground text-sm">
          {"لديك ٥ تقارير جاهزة ومتاحة للتصدير."->React.string}
        </Card.Content>
      </Card>
    </Tabs.Content>
    <Tabs.Content value="settings">
      <Card dir="rtl">
        <Card.Header>
          <Card.Title> {"الإعدادات"->React.string} </Card.Title>
          <Card.Description>
            {"إدارة تفضيلات حسابك وخياراته. تخصيص تجربتك لتناسب احتياجاتك."->React.string}
          </Card.Description>
        </Card.Header>
        <Card.Content className="text-muted-foreground text-sm">
          {"تكوين الإشعارات والأمان والسمات."->React.string}
        </Card.Content>
      </Card>
    </Tabs.Content>
  </Tabs>
