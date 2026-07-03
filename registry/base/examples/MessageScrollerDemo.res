@react.componentWithProps(Demo.Props.t)
let make = ({}: Demo.Props.t) =>
  <Card className="h-[480px] w-full max-w-xl">
    <Card.Header>
      <Card.Title> {"How can I help you today?"->React.string} </Card.Title>
      <Card.Description> {"Static transcript preview"->React.string} </Card.Description>
    </Card.Header>
    <Card.Content className="min-h-0 flex-1 overflow-hidden p-0">
      <MessageScroller.Provider defaultScrollPosition=LastAnchor>
        <MessageScroller>
          <MessageScroller.Viewport>
            <MessageScroller.Content className="gap-5 p-(--card-spacing)">
              <MessageScroller.Item messageId="m1" scrollAnchor=true>
                <Message align=End>
                  <Message.Content>
                    <Bubble>
                      <Bubble.Content>
                        {"Can you check whether the docs examples still compile?"->React.string}
                      </Bubble.Content>
                    </Bubble>
                  </Message.Content>
                </Message>
              </MessageScroller.Item>
              <MessageScroller.Item messageId="m2">
                <Message>
                  <Message.Content>
                    <Bubble variant=Muted>
                      <Bubble.Content>
                        <span className="whitespace-pre-wrap">
                          {"Yes. I added the missing preview components, regenerated the loader, and kept the class hooks aligned with upstream."->React.string}
                        </span>
                      </Bubble.Content>
                    </Bubble>
                  </Message.Content>
                </Message>
              </MessageScroller.Item>
              <MessageScroller.Item messageId="m3" scrollAnchor=true>
                <Message align=End>
                  <Message.Content>
                    <Bubble>
                      <Bubble.Content>
                        {"Great. Please run classname and pixel checks next."->React.string}
                      </Bubble.Content>
                    </Bubble>
                  </Message.Content>
                </Message>
              </MessageScroller.Item>
              <MessageScroller.Item messageId="status">
                <Marker role="status">
                  <Marker.Icon>
                    <Spinner />
                  </Marker.Icon>
                  <Marker.Content> {"Running visual checks"->React.string} </Marker.Content>
                </Marker>
              </MessageScroller.Item>
            </MessageScroller.Content>
          </MessageScroller.Viewport>
          <MessageScroller.Button ariaLabel="Scroll to latest" />
        </MessageScroller>
      </MessageScroller.Provider>
    </Card.Content>
    <Card.Footer>
      <div className="flex w-full items-center gap-2">
        <Input placeholder="Ask me anything..." readOnly=true value="Regenerate the registry" />
        <Button size=Icon ariaLabel="Send message">
          <Icons.ArrowUp />
        </Button>
      </div>
    </Card.Footer>
  </Card>
