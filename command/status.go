package command

import (
	"strings"
)

type StatusCommand struct {
	Meta
}

func (c *StatusCommand) Run(args []string) int {
	// Write your code here

	return 0
}

func (c *StatusCommand) Synopsis() string {
	return "Print the git status for each repo."
}

func (c *StatusCommand) Help() string {
	helpText := `

`
	return strings.TrimSpace(helpText)
}
