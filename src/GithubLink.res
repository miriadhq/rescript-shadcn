@@directive("'use client'")

module StarsCount = {
  @react.component
  let make = async () => {
    let data = await Next.fetch(
      "https://api.github.com/repos/miriadhq/rescript-shadcn",
      ~init={
        next: {revalidate: 86400},
      },
    )
    switch await data->WebAPI.Response.json {
    | Object(dict{"stargazers_count": JSON.Number(starGazersCount)}) =>
      let formattedCount =
        starGazersCount >= 1000.0
          ? `${Math.round(starGazersCount * 0.001)->Float.toLocaleString}}k`
          : starGazersCount->Float.toLocaleString

      <span className="w-fit text-xs text-muted-foreground tabular-nums">
        {formattedCount->React.string}
      </span>
    | _ => React.null
    }
  }
}

@react.component
let make = () => {
  <Button
    size=Icon
    variant=Ghost
    className="size-8 shrink-0 shadow-none"
    nativeButton=false
    render={<Next.Link
      href="https://github.com/miriadhq/rescript-shadcn" target="_blank" rel="noreferrer"
    />}
  >
    <BrandIcons.GitHub className="size-4" />
    // removed for now because you can't use a server component inside a client component
    // <React.Suspense fallback={<Skeleton className="h-4 w-[42px]" />}>
    //   <StarsCount />
    // </React.Suspense>
  </Button>
}
