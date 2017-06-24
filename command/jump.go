package command

import (
	"strings"
)

type JumpCommand struct {
	Meta
}

func (c *JumpCommand) Run(args []string) int {
	// Write your code here

	return 0
}

func (c *JumpCommand) Synopsis() string {
	return "Goto the root directory of your repos."
}

func (c *JumpCommand) Help() string {
	helpText := `

`
	return strings.TrimSpace(helpText)
}
