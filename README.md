# HifBaselineConverter


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hif_baseline_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hif_baseline_converter

## Usage

To run and post directly -

Add to a rails project and run with

    $ rake he:parse_hif_sheet['<path to spreadsheet>']

or, execute directly from the gem

    $ bin/baseline_converter <path to spreadsheet> http://<api url>/project/create
