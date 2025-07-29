#
# Safely delete a git feature branch after it has been merged.
# Anticipates rebased merges via the Github UI, and so
# proactively rebases the local feature branch prior to 
# attempting to "safely" delete it
#

function safeDeleteBranch --description "Safely delete a potentially rebased git branch"
    # Check if branch name was provided
    if test (count $argv) -eq 0
        echo "Usage: delete_feature_branch <branch-name>"
        return 1
    end

    set branch_name $argv[1]

    echo "🔄 Starting cleanup process for branch: $branch_name"

    # Switch to main
    echo "📍 Switching to main..."
    git checkout main
    if test $status -ne 0
        echo "❌ Failed to checkout main"
        return 1
    end

    # Pull from origin
    echo "⬇️  Pulling latest changes from origin..."
    git pull origin main
    if test $status -ne 0
        echo "❌ Failed to pull from origin"
        return 1
    end

    # Switch to feature branch
    echo "🌿 Switching to $branch_name..."
    git checkout $branch_name
    if test $status -ne 0
        echo "❌ Failed to checkout $branch_name"
        return 1
    end

    # Rebase against main
    echo "🔀 Rebasing $branch_name against main..."
    git rebase main
    if test $status -ne 0
        echo "❌ Rebase failed - you may need to resolve conflicts manually"
        echo "   Run 'git rebase --abort' to cancel, or resolve conflicts and continue"
        return 1
    end

    # Switch back to main
    echo "📍 Switching back to main..."
    git checkout main
    if test $status -ne 0
        echo "❌ Failed to checkout main after rebase"
        return 1
    end

    # Try to delete with -d
    echo "🗑️  Attempting to delete $branch_name with -d flag..."
    git branch -d $branch_name
    if test $status -eq 0
        echo "✅ Successfully deleted $branch_name"
    else
        echo "⚠️  Branch deletion failed with -d flag"
        echo "   If you're sure the branch is merged, use: git branch -D $branch_name"
    end
end

