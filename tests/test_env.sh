PATH=$(atf_get_srcdir)/..:$PATH

init_env() {
	export ROOT=$PWD LIBDIR=$(atf_get_srcdir)/.. MOCK=echo
}

init_tests() {
	TESTS="$@"
	export TESTS
	for t; do
		atf_test_case $t
	done
}

atf_init_test_cases() {
	for t in $TESTS; do
		atf_add_test_case $t
	done
}

test_usage() {
	local prog="$1"
	init_env
	atf_check -s exit:0 \
		-o match:"^usage: $prog" \
		-e empty \
		$prog -h

	atf_check -s exit:1 \
		-o empty \
		-e match:"^usage: $prog" \
		$prog -INVALID
}

